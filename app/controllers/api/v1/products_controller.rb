class Api::V1::ProductsController < Api::V1::HomeController
  # before_action :authenticate_user!
  protect_from_forgery with: :null_session
  before_action :authenticate_request

  def index
    products = Product.all
    all_products = products.map do |product|
                    {
                      id: product.id,
                      name: product.name,
                      description: product.description,
                      price: product.price,
                      make: product.make
                    }
    end
    render json: { all_products: all_products, status: 'success', message: 'List Of All Products' }
  end

  def create
    product = Product.create(product_params)
    if product
      render json: { product: product, status: 'success', message: 'Product Created Successfully...' }
    else
      render json: { product: product, status: 'errorr', message: 'Product Not Created...' }
    end
  end 

  def create_cart
    cart = Cart.create(cart_params)
    if cart
      render json: { cart: cart, status: 'success', message: 'cart Created Successfully...' }
    else
      render json: { cart: cart, status: 'errorr', message: 'Product Not Created...' }
    end
  end

  def update
    product = Product.find_by(id: params[:product_id])
    product = product.update(name: params[:name], description: params[:description], make: params[:make], price: params[:price])
    product = Product.find_by(id: params[:product_id])

    if product
      render json: { product: product, status: 'success', message: 'Product Updated Successfully...' }
    else
      render json: { product: product, status: 'errorr', message: 'Product Not Updated...' }
    end
  end

  def destroy
    product = Product.find_by(id: params[:product_id])
    if product.destroy
      render json: { status: 'success', message: 'Product Destroy Successfully...' }
    else
      render json: { status: 'errorr', message: 'Product Not Destroy...' }
    end
  end

  def add_product_to_cart
    cart = Cart.create(user_id: params[:user_id], product_id: params[:product_id])
    if cart
      render json: { cart: cart, status: 'success', message: 'Product Added Successfully...' }
    else
      render json: { cart: cart, status: 'errorr', message: 'Product Not Added...' }
    end
  end

  def get_cart_for_user
    cart = if params[:product_id].present?
             Cart.where(user_id: params[:user_id], product_id: params[:product_id])
           else
             Cart.where(user_id: params[:user_id])
           end

          if cart
            render json: { cart: cart, status: 'success', message: 'List of All Carts ...' }
          else
            render json: { cart: cart, status: 'errorr', message: 'error ...' }
          end
  end

  def remove_product_to_cart
    cart = Cart.find_by(id: params[:cart_id])
    if cart.destroy
      render json: { status: 'success', message: 'Product Removed Successfully...' }
    else
      render json: { status: 'errorr', message: 'Product Not Removed...' }
    end
  end

  def get_cart_user; end

  private

  def product_params
    params.permit(:name, :description, :price, :make)
  end

  def cart_params
    params.permit(:user_id, :product_id)
  end
end
