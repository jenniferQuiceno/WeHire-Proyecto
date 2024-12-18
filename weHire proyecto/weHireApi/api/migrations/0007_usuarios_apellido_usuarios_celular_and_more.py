# Generated by Django 5.1.3 on 2024-11-23 21:33

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('api', '0006_auto_20241121_2213'),
    ]

    operations = [
        migrations.AddField(
            model_name='usuarios',
            name='apellido',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AddField(
            model_name='usuarios',
            name='celular',
            field=models.CharField(max_length=50, null=True),
        ),
        migrations.AddField(
            model_name='usuarios',
            name='fecha_nacimiento',
            field=models.DateTimeField(null=True),
        ),
        migrations.AddField(
            model_name='usuarios',
            name='hoja_vida',
            field=models.FileField(blank=True, null=True, upload_to='uploads/'),
        ),
        migrations.AddField(
            model_name='usuarios',
            name='telefono',
            field=models.CharField(max_length=50, null=True),
        ),
    ]
