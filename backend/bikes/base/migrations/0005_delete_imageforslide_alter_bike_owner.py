# Generated by Django 4.1.3 on 2022-11-18 14:15

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('base', '0004_imageforslide'),
    ]

    operations = [
        migrations.DeleteModel(
            name='ImageForSlide',
        ),
        migrations.AlterField(
            model_name='bike',
            name='owner',
            field=models.ForeignKey(blank=True, null=True, on_delete=django.db.models.deletion.DO_NOTHING, to=settings.AUTH_USER_MODEL),
        ),
    ]
