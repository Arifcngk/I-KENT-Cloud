<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\User;
use App\Models\Post;

class PostController extends Controller
{
    // get all posts
    public function index()
    {
        return response([
            'posts' => Post::orderBy('created_at', 'desc')->with('user:id,name,image')->withCount('comments', 'likes')
                ->with('likes', function ($like) {
                    return $like->where('user_id', auth()->user()->id)
                        ->select('id', 'user_id', 'post_id')->get();
                })
                ->get()
        ], 200);
    }

    // get single post
    public function show($id)
    {
        return response([
            'post' => Post::where('id', $id)->withCount('comments', 'likes')->get()
        ], 200);
    }

    // create a post
    // public function store(Request $request)
    // {
    //     //validate fields
    //     $attrs = $request->validate([
    //         'body' => 'required|string'
    //     ]);

    //     if ($request->hasFile('image')) {
    //         $image = $request->file('image')->store('posts', 'public');
    //     } else {
    //         $image = null;
    //     }

    //     $post = Post::create([
    //         'body' => $attrs['body'],
    //         'user_id' => auth()->user()->id,
    //         'image' => $image
    //     ]);

    //     // for now skip for post image

    //     return response([
    //         'message' => 'Post created.',
    //         'post' => $post,
    //     ], 200);
    // }

    public function store(Request $request)
    {
        // Validate fields
        $attrs = $request->validate([
            'body' => 'required|string',
            'image' => 'nullable|string', // Base64 formatında gelen resim
        ]);

        $image = null;

        // Eğer bir resim gönderildiyse, base64 verisini dosyaya dönüştürüp kaydedin
        if ($request->has('image')) {
            // Base64 verisini dosyaya dönüştürme
            $imageData = base64_decode($attrs['image']);

            // Resim dosyasının adını oluşturun
            $imageName = uniqid('image_') . '.png'; // Örnek olarak PNG formatı kullanıldı, dosya uzantısını gerektiğine göre ayarlayabilirsiniz.

            // Dosyayı depolama dizinine kaydetme
            $imagePath = storage_path('app/public/posts/') . $imageName;

            // Dosyayı kaydetme
            file_put_contents($imagePath, $imageData);

            // Dosyanın yolunu saklayın
            $image = 'posts/' . $imageName;
        }

        // Postu oluşturun
        $post = Post::create([
            'body' => $attrs['body'],
            'user_id' => auth()->user()->id,
            'image' => $image
        ]);

        return response([
            'message' => 'Post created.',
            'post' => $post,
        ], 200);
    }


    // update a post
    public function update(Request $request, $id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if ($post->user_id != auth()->user()->id) {
            return response([
                'message' => 'Permission denied.'
            ], 403);
        }

        //validate fields
        $attrs = $request->validate([
            'body' => 'required|string'
        ]);

        $post->update([
            'body' =>  $attrs['body']
        ]);

        // for now skip for post image

        return response([
            'message' => 'Post updated.',
            'post' => $post
        ], 200);
    }

    //delete post
    public function destroy($id)
    {
        $post = Post::find($id);

        if (!$post) {
            return response([
                'message' => 'Post not found.'
            ], 403);
        }

        if ($post->user_id != auth()->user()->id) {
            return response([
                'message' => 'Permission denied.'
            ], 403);
        }

        $post->comments()->delete();
        $post->likes()->delete();
        $post->delete();

        return response([
            'message' => 'Post deleted.'
        ], 200);
    }
}
