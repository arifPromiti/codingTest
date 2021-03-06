@extends('layouts.app')

@section('content')

    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">Products</h1>
    </div>


    <div class="card">
        <form action="{{URL::to("/filterProduct")}}" method="post" class="card-header">
            @csrf
            <div class="form-row justify-content-between">
                <div class="col-md-2">
                    <input type="text" name="title" placeholder="Product Title" class="form-control">
                </div>
                <div class="col-md-2">
                    <select name="variant" id="" class="form-control">
                        <option value=""> Select One</option>
                        @foreach ($variants as $vitem)
                            <optgroup label="{{ $vitem->title }}">
                                @foreach ($pvariants as $pitem)
                                    @if($pitem->variant_id == $vitem->id)
                                        <option value="{{ $pitem->variant }}">{{ $pitem->variant }}</option>
                                    @endif
                                @endforeach
                            </optgroup>
                        @endforeach
                    </select>
                </div>

                <div class="col-md-3">
                    <div class="input-group">
                        <div class="input-group-prepend">
                            <span class="input-group-text">Price Range</span>
                        </div>
                        <input type="text" name="price_from" aria-label="First name" placeholder="From" class="form-control">
                        <input type="text" name="price_to" aria-label="Last name" placeholder="To" class="form-control">
                    </div>
                </div>
                <div class="col-md-2">
                    <input type="date" name="date" placeholder="Date" class="form-control">
                </div>
                <div class="col-md-1">
                    <button type="submit" class="btn btn-primary float-right"><i class="fa fa-search"></i></button>
                </div>
            </div>
        </form>

        <div class="card-body">
            <div class="table-response">
                <table class="table">
                    <thead>
                    <tr>
                        <th>#</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Variant</th>
                        <th width="150px">Action</th>
                    </tr>
                    </thead>

                    <tbody>
                        @php
                            $i = 1;
                        @endphp
                        @foreach ($product as $item)
                            <tr>
                                <td>{{ $i++ }}</td>
                                <td>{{ $item->title }} <br> Created at : {{ date('d-m-Y',strtotime($item->created_at) ) }}</td>
                                <td>{{ $item->description }}</td>
                                <td>
                                    <dl class="row mb-0" style="height: 80px; overflow: hidden" id="variant{{ $item->id }}">
                                        @foreach ($productVariantPrice as $pvpitem)
                                            @if($pvpitem->product_id ==  $item->id)
                                                <dt class="col-sm-3 pb-0">
                                                    @foreach ($productVariant as $pvitem)
                                                        @if($pvitem->id == $pvpitem->product_variant_one)
                                                            {{$pvitem->variant }}
                                                        @endif
                                                    @endforeach
                                                    @foreach ($productVariant as $pvitem)
                                                        @if($pvitem->id == $pvpitem->product_variant_two)
                                                            / {{$pvitem->variant }}
                                                        @endif
                                                    @endforeach
                                                    @foreach ($productVariant as $pvitem)
                                                        @if($pvitem->id == $pvpitem->product_variant_three)
                                                            / {{$pvitem->variant }}
                                                        @endif
                                                    @endforeach
                                                </dt>
                                                <dd class="col-sm-9">
                                                    <dl class="row mb-0">
                                                        <dt class="col-sm-4 pb-0">Price : {{ number_format($pvpitem->price,2) }}</dt>
                                                        <dd class="col-sm-8 pb-0">InStock : {{ number_format($pvpitem->stock,2) }}</dd>
                                                    </dl>
                                                </dd>
                                            @endif
                                        @endforeach
                                    </dl>
                                    <button onclick="$('#variant{{ $item->id }}').toggleClass('h-auto')" class="btn btn-sm btn-link">Show more</button>
                                </td>
                                <td>
                                    <div class="btn-group btn-group-sm">
                                        <a href="{{ route('product.edit', $item->id) }}" class="btn btn-success">Edit</a>
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>

                </table>
            </div>

        </div>

        <div class="card-footer">
            <div class="row justify-content-between">
                <div class="col-md-6">
                    <p>Showing 1 to 10 out of 100</p>
                </div>
                <div class="col-md-2">

                </div>
            </div>
        </div>
    </div>

@endsection

@section('scripts')

    {{-- <script> 
        function filter(){
            var url = '';
            $.ajax({
                type: "GET",
                url: "url",
                dataType: "JSON",
                success: function (data) {
                    
                },error: function (){
                    alert('sorry');
                }
            }); 
        }
    </script> --}}
    
@endsection
