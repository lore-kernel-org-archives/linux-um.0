Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jkMgA-00060M-UE
 for linux-um@lists.infradead.org; Sun, 14 Jun 2020 07:03:44 +0000
Subject: Re: [PATCH] Fix null pointer dereference in vector_user_bpf
References: <20200614012001.18468-1-gaurav1086@gmail.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <39158d22-9997-32ef-c599-7e6a98988a38@cambridgegreys.com>
Date: Sun, 14 Jun 2020 07:38:51 +0100
MIME-Version: 1.0
In-Reply-To: <20200614012001.18468-1-gaurav1086@gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Gaurav Singh <gaurav1086@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>, John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>, Alex Dewar <alex.dewar@gmx.co.uk>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, "open list:BPF (Safe dynamic programs and tools)" <netdev@vger.kernel.org>, "open list:BPF (Safe dynamic programs and tools)" <bpf@vger.kernel.org>

On 14/06/2020 02:19, Gaurav Singh wrote:
> The bpf_prog is being checked for !NULL after uml_kmalloc
> but later its used directly for example:
> bpf_prog->filter = bpf and is also later returned upon
> success. Fix this, do a NULL check and return right away.
> 
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> ---
>   arch/um/drivers/vector_user.c | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index c4a0f26b2824..0e6d6717bf73 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -789,10 +789,12 @@ void *uml_vector_user_bpf(char *filename)
>   		return false;
>   	}
>   	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> -	if (bpf_prog != NULL) {
> -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> -		bpf_prog->filter = NULL;
> +	if (bpf_prog == NULL) {
> +		printk(KERN_ERR "Failed to allocate bpf prog buffer");
> +		return NULL;
>   	}
> +	bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> +	bpf_prog->filter = NULL;
>   	ffd = os_open_file(filename, of_read(OPENFLAGS()), 0);
>   	if (ffd < 0) {
>   		printk(KERN_ERR "Error %d opening bpf file", -errno);
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>
-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

