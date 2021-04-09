<?php

namespace App\Http\Controllers;

use App\Models\Product;
use App\Models\ProductVariant;
use App\Models\ProductVariantPrice;
use App\Models\Variant;
use Illuminate\Http\Request;
use DB;
use Validator;
use Session;

class ProductController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function index()
    {   
        $variants            = Variant::select('id','title')->get();
        $pvariants           = ProductVariant::select('variant_id','variant')->get()->unique('variant');
        $product             = Product::all();
        $productVariant      = ProductVariant::all();
        $productVariantPrice = ProductVariantPrice::all();
        return view('products.index', compact('variants','pvariants','product','productVariant','productVariantPrice'));
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Http\Response|\Illuminate\View\View
     */
    public function create()
    {
        $variants = Variant::all();
        return view('products.create', compact('variants'));
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @return \Illuminate\Http\JsonResponse
     */
    public function store(Request $request)
    {
        $validator = Validator::make($request->all(),[
            'title'       => 'required',
            'sku'         => 'required',
            'description' => 'required',
            'variant'     => 'required',
            'variant_id'  => 'required',
            'price'       => 'required',
            'stock'       => 'required',
        ]);
        //dd($validator);
        //exit();
		if ($validator->fails()){
            Session::put('msg','<script>
                                        $(function(){
                                            swal({
                                            title: "Sorry!",
                                            icon: "error",
                                            button: false,
                                            timer: 1500
                                            });
                                        });
                                </script>');
            return redirect()->back()->withErrors($validator)->withInput();
        }else{

            $data = [
                'title'       => $request->title,
                'sku'         => $request->sku,
                'description' => $request->description
            ];

            $variant    = $request->variant;
            $variant_id = $request->variant_id;
            $price      = $request->price;
            $stock      = $request->stock;
            
            $result = DB::transaction(function() use($data,$variant,$variant_id,$price,$stock){

                $result = Product::create($data);
                $i = 0;
                foreach($variant as $value){
                    $v_variants = explode('/',$variant[$i]);
                    $v_variant_ids = explode('/',$variant_id[$i]);

                    // dd(explode('/',$variant[$i],-1), explode('/',$variant[$i]));

                    $variant_price_data['product_variant_one']   = NULL;
                    $variant_price_data['product_variant_two']   = NULL;
                    $variant_price_data['product_variant_three'] = NULL;
                    $variant_price_data['price']                 = $price[$i];
                    $variant_price_data['stock']                 = $stock[$i];
                    $variant_price_data['product_id']            = $result->id;

                    $x = 0;
                    foreach($v_variants as $value){
                        $p_variant['variant']    = $v_variants[$x];
                        $p_variant['variant_id'] = $v_variant_ids[$x];
                        $p_variant['product_id'] = $result->id;

                        $ins = ProductVariant::create($p_variant);

                        if($ins->id > 0){
                            $vins = $ins->id;
                        }else{
                            $vins = NULL;
                        }
                        
                        if(($x == 0)){
                            $variant_price_data['product_variant_one'] = $vins;
                        }elseif(($x == 1)){
                            $variant_price_data['product_variant_two'] = $vins;
                        }elseif(($x == 2)){
                            $variant_price_data['product_variant_three'] = $vins;
                        }
                        $x++;
                    }

                    $final = ProductVariantPrice::create($variant_price_data);
                    $i++;
                }

                return $final;
            });

            if($result == true){
                Session::put('msg', '<script>
                                            $(function(){
                                                swal({
                                                title: "Done!",
                                                icon: "success",
                                                button: false,
                                                timer: 1500
                                                });
                                            });
                                    </script>');
                return redirect()->back();
            }else{
                Session::put('msg', '<script>
                                            $(function(){
                                                swal({
                                                title: "Sorry!",
                                                icon: "error",
                                                button: false,
                                                timer: 1500
                                                });
                                            });
                                    </script>');
                return redirect()->back();
            }
        }
    }


    /**
     * Display the specified resource.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function show($product)
    {

    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        $productId           = $id;
        $variants            = Variant::all();
        $product             = Product::where('id',$id)->first();
        $productVariant      = ProductVariant::where('product_id',$id)->get();
        $productVariantPrice = ProductVariantPrice::where('product_id',$id)->with('getproduct_variant_oneData','getproduct_variant_twoData','getproduct_variant_threeData')->get();
        return view('products.edit', compact('productId','variants','product','productVariant','productVariantPrice'));
    }

    /**
     * Update the specified resource in storage.
     *
     * @param \Illuminate\Http\Request $request
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        $validator = Validator::make($request->all(),[
            'title'       => 'required',
            'sku'         => 'required',
            'description' => 'required',
            'variant'     => 'required',
            'variant_id'  => 'required',
            'price'       => 'required',
            'stock'       => 'required',
        ]);
        //dd($validator);
        //exit();
		if ($validator->fails()){
            Session::put('msg','<script>
                                        $(function(){
                                            swal({
                                            title: "Sorry!",
                                            icon: "error",
                                            button: false,
                                            timer: 1500
                                            });
                                        });
                                </script>');
            return redirect()->back()->withErrors($validator)->withInput();
        }else{

            $data = [
                'title'       => $request->title,
                'sku'         => $request->sku,
                'description' => $request->description
            ];

            $variant    = $request->variant;
            $variant_id = $request->variant_id;
            $price      = $request->price;
            $stock      = $request->stock;
            
            $result = DB::transaction(function() use($id,$data,$variant,$variant_id,$price,$stock){

                $result = Product::where('id',$id)->update($data);

                ProductVariant::where('product_id',$id)->delete();
                ProductVariantPrice::where('product_id',$id)->delete();

                $i = 0;
                foreach($variant as $value){
                    $v_variants = explode('/',$variant[$i]);
                    $v_variant_ids = explode('/',$variant_id[$i]);

                    // dd(explode('/',$variant[$i],-1), explode('/',$variant[$i]));

                    $variant_price_data['product_variant_one']   = NULL;
                    $variant_price_data['product_variant_two']   = NULL;
                    $variant_price_data['product_variant_three'] = NULL;
                    $variant_price_data['price']                 = $price[$i];
                    $variant_price_data['stock']                 = $stock[$i];
                    $variant_price_data['product_id']            = $id;

                    $x = 0;
                    foreach($v_variants as $value){
                        $p_variant['variant']    = $v_variants[$x];
                        $p_variant['variant_id'] = $v_variant_ids[$x];
                        $p_variant['product_id'] = $id;

                        $ins = ProductVariant::create($p_variant);

                        if($ins->id > 0){
                            $vins = $ins->id;
                        }else{
                            $vins = NULL;
                        }
                        
                        if(($x == 0)){
                            $variant_price_data['product_variant_one'] = $vins;
                        }elseif(($x == 1)){
                            $variant_price_data['product_variant_two'] = $vins;
                        }elseif(($x == 2)){
                            $variant_price_data['product_variant_three'] = $vins;
                        }
                        $x++;
                    }

                    $final = ProductVariantPrice::create($variant_price_data);
                    $i++;
                }

                return $final;
            });

            if($result == true){
                Session::put('msg', '<script>
                                            $(function(){
                                                swal({
                                                title: "Done!",
                                                icon: "success",
                                                button: false,
                                                timer: 1500
                                                });
                                            });
                                    </script>');
                return redirect()->back();
            }else{
                Session::put('msg', '<script>
                                            $(function(){
                                                swal({
                                                title: "Sorry!",
                                                icon: "error",
                                                button: false,
                                                timer: 1500
                                                });
                                            });
                                    </script>');
                return redirect()->back();
            }
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param \App\Models\Product $product
     * @return \Illuminate\Http\Response
     */
    public function destroy(Product $product)
    {
        //
    }
}
