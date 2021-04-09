<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use App\Models\Product;
use App\Models\ProductVariant;

class ProductVariantPrice extends Model
{
    protected $fillable = [
        'product_variant_one',
        'product_variant_two',
        'product_variant_three',
        'price',
        'stock',
        'product_id'
    ];

    public function getProductData(){
        return $this->belongsTo(Product::class, 'product_id');
    }

    public function getproduct_variant_oneData(){
        return $this->belongsTo(ProductVariant::class, 'product_variant_one');
    }

    public function getproduct_variant_twoData(){
        return $this->belongsTo(ProductVariant::class, 'product_variant_two');
    }

    public function getproduct_variant_threeData(){
        return $this->belongsTo(ProductVariant::class, 'product_variant_three');
    }
}
