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
    public function index(request $request)
    {   
        $variants            = Variant::select('id','title')->get();
        $pvariants           = $this->productVariant();
        $product             = $this->filter($request);
        $productVariant      = ProductVariant::all();
        $productVariantPrice = ProductVariantPrice::all();
        return view('products.index', compact('variants','pvariants','product','productVariant','productVariantPrice'));
    }

    function productVariant(){
        $data = ProductVariant::select('variant_id','variant')->get()->unique('variant');
        return $data;
    }

    function filter($request){
        
        $variant    = $request->variant;
        $price_from = $request->price_from;
        $price_to   = $request->price_to;

        $title      = $request->title;
        $date       = $request->date;
        $product    = NULL;

        // dd(date(strtotime($date))); 
        // die();

        If(isset($variant) && isset($price_from) && isset($price_to) ){
            $product = $this->variantPrice($variant,$price_from,$price_to);
        }elseif(isset($variant)){
            $product = ProductVariant::select('product_id')->where('variant', $variant)->get();
        }

        If(isset($title) && isset($date) && isset($product)){
            $data = Product::whereDate('created_at',date('Y-m-d',strtotime($date)))->whereIn('id',$product)->where('title', 'like',"%{$title}%")->get();
        }elseif(isset($title) && isset($date)){
            $data = Product::whereDate('created_at',date('Y-m-d',strtotime($date)))->where('title', 'like',"%{$title}%")->get();
        }elseif(isset($title) && isset($product)){
            $data = Product::where('title', 'like',"%{$title}%")->whereIn('id',$product)->get();
        }elseif(isset($product) && isset($date)){
            $data = Product::whereDate('created_at',date('Y-m-d',strtotime($date)))->whereIn('id',$product)->get();
        }elseif(isset($title)){
            $data = Product::where('title', 'like',"%{$title}%")->get();
        }elseif(isset($date)){
            $data = Product::whereDate('created_at',date('Y-m-d',strtotime($date)))->get();
        }elseif(isset($product)){
            $data = Product::whereIn('id',$product)->get();
        }else{
            $data = Product::all();
        }

        return $data;
    }

    function variantPrice($variant,$price_from,$price_to){
        $productVariant = ProductVariant::select('id')->where('variant', $variant)->get();
        $products = ProductVariantPrice::select('product_id')->whereIn('product_id',$productVariant)->whereBetween('price', [$price_from, $price_to])->get();

        return $products;
    }


}
