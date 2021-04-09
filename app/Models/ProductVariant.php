<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class ProductVariant extends Model
{
    protected $fillable = [
        'variant', 
        'variant_id', 
        'product_id'
    ];

    public function getProductData(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function getVariantData(){
        return $this->belongsTo(Variant::class, 'variant_id');
    }

    public function getproduct_variant_oneData(){
        return $this->hasMany(ProductVariant::class, 'product_variant_one', 'id');
    }

    public function getproduct_variant_twoData(){
        return $this->hasMany(ProductVariant::class, 'product_variant_two', 'id');
    }

    public function getproduct_variant_threeData(){
        return $this->hasMany(ProductVariant::class, 'product_variant_three', 'id');
    }
}
