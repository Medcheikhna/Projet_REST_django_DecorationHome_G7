# Generated by Django 4.2.1 on 2023-05-16 09:56

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("shop", "0001_initial"),
    ]

    operations = [
        migrations.AddField(
            model_name="order",
            name="orderItems",
            field=models.ManyToManyField(through="shop.OrderItems", to="shop.product"),
        ),
    ]
