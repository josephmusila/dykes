# Generated by Django 4.1.3 on 2022-11-18 11:11

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0002_bike_alter_user_groups_alter_user_user_permissions_and_more'),
    ]

    operations = [
        migrations.RenameField(
            model_name='bike',
            old_name='decription',
            new_name='description',
        ),
    ]
