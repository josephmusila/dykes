# Generated by Django 4.1.3 on 2022-11-19 13:16

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0006_alter_bike_owner'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='rentals',
            name='owner',
        ),
    ]