from django.contrib import admin

# Register your models here.
from . import models




class UserAdmin(admin.ModelAdmin):
    list_display=("id","first_name","last_name","email","location",)
    ordering = ['first_name']
    search_fields = ['first_name']



class BikeAdmin(admin.ModelAdmin):
    list_display=("id","name","description","price","owner",)
    ordering = ['name']
    search_fields = ['name']



admin.site.register(models.User,UserAdmin),
admin.site.register(models.Bike,BikeAdmin)