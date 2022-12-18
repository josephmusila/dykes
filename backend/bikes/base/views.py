from django.shortcuts import render
from . import services,authentication
from . import serializers as user_serializer
from .models import User,Bike,Rentals,RepairServices
from rest_framework import views,response,exceptions,permissions,generics        
from django.db.models import Q   
     
# Create your views here.


class LoginAPi(views.APIView):

    def post(self,request):

        email=request.data["email"]
        password=request.data["password"]
       
        user=services.user_email_selector(email=email)

        
        # cust=RegisterApi.post(self,request);

        if user is None:

            raise exceptions.AuthenticationFailed("Invalid credentials")

        if not user.check_password(raw_password=password):

            raise exceptions.AuthenticationFailed("Invalid Credentials")
        
        queryset=User.objects.get(email=user)
        serializer=user_serializer.UserSerializer(queryset,context={"request":request})
        
        # info = RegisterApi.getData()
        token=services.create_token(user_id=user.id)
        resp=response.Response({"token":token,"user": serializer.data})
        resp.set_cookie(key="jwt",value=token,httponly=True)
        return resp

class RegisterApi(views.APIView):
    
    def post(self,request):


        serializer=user_serializer.UserSerializer(data=request.data,context={"request":request})
        serializer.is_valid(raise_exception=True)

        data=serializer.validated_data
        serializer.instance = services.create_user(user=data)
        print(data)


        # return response.Response(data=serializer.data)
        return response.Response({"message":"Account created Succesfully","user":serializer.data})


    def getData(request,self):
        info = self.post(self,request)
        return info

class AddBike(generics.ListAPIView):
    serializer_class=user_serializer.BikeSerializer
    allowed_methods=["POST","GET"]
    queryset=Bike.objects.all()

    def post(self,request):

        data=request.data
        serializer=self.serializer_class(data=data,context={"request":request})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        print(data['owner'])
        return response.Response(serializer.data)


    def get(self, request, *args, **kwargs):
        # print( kwargs['search'])
        # AddBike.queryset=Bike.objects.filter(Q(location__icontains=kwargs['search']))
        AddBike.queryset=Bike.objects.all()
                                                 
        
        return self.list(request={"request":request}, *args, **kwargs) 



    def getData(request,self):
        info = self.post(self,request)
        return info


class RentalsView(generics.ListAPIView):
    queryset=Rentals.objects.all()
    serializer_class=user_serializer.RentalSerializer
    allowed_methods=["POST","GET"]

   
    def post(self,request):
        data=request.data
        serializer=self.serializer_class(data=data,context={"request":request})
        serializer.is_valid(raise_exception=True)
        serializer.save()
        print(data)
        return response.Response(serializer.data)


    def get(self, request, *args, **kwargs):
        # print( kwargs['search'])
        # AddBike.queryset=Bike.objects.filter(Q(location__icontains=kwargs['search']))
        RentalsView.queryset=Rentals.objects.all()
        # data=self.serializer_class(data=data)                                         
        
        return self.list(request={"request":request}, *args, **kwargs) 

    def getData(request,self):
        info = self.post(self,request)
        return info

class RepairServicesView(views.APIView):
    serializer_class=user_serializer.RepairServiceSerializer
    queryset=RepairServices.objects.all()

    def post(self,request):
        data=request.data
        customer=data["customer"]
        bike=data["bike"]

        ownership=Bike.objects.filter(owner__id=customer)
        if len(ownership) == 0:
            return response.Response({"ownership_error":"Only the owner can ask for repair of this bike"})
        else:   
        
            serializer=user_serializer.RepairServiceSerializer(data=data,many=False)
            serializer.is_valid(raise_exception=True)
            serializer.save()
            return response.Response(serializer.data)


class SearchBike(generics.ListAPIView):
    serializer_class=user_serializer.BikeSerializer
    queryset=Bike.objects.all()
    allowed_methods=["POST","GET"]

    def get(self, request, *args, **kwargs):
        SearchBike.queryset=Bike.objects.filter(Q(name__icontains=kwargs['search']))
        return self.list(request, *args, **kwargs)

class GetLocations(views.APIView):
    

    def get():
        locations=[]
        