<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $fillable = [
        'title', 'sku', 'description'
    ];

    public function getProductVariantData(){
        return $this->hasMany(ProductVariant::class, 'product_id', 'id');
    }

    public function getProductVariantPriceData(){
        return $this->hasMany(ProductVariantPrice::class, 'product_id', 'id');
    }
}
