from .  import views
from django.urls import path

urlpatterns=[
    path("user/register",views.RegisterApi.as_view(),name="register"),
    path("user/login",views.LoginAPi.as_view(),name="login"),


    path("bikes/add",views.AddBike.as_view(),name="add_bike"),
    path("bikes/list",views.AddBike.as_view(),name="get_all"),


    path("rentals/new",views.RentalsView.as_view(),name="new_rentals"),
    path("bikes/search/<search>",views.SearchBike.as_view(),name="search"),

    
    path("repairs",views.RepairServicesView.as_view(),name="repairs")
]