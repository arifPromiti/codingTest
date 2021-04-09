<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\ProductVariantPrice;
use App\Models\Variant;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductFilterController extends Controller
{
    public function index()
    {   
        $variants            = Variant::all();
        $pvariants           = $this->productVariant();
        $product             = Product::all();
        $productVariant      = ProductVariant::all();
        $productVariantPrice = ProductVariantPrice::all();
        return view('products.index', compact('variants','pvariants','product','productVariant','productVariantPrice'));
    }

    function productVariant(){
        return DB::table('product_variants')->select('variant','variant_id','id')->get();
    }
}
