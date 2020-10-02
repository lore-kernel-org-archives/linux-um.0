Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 3/6] docs: virt: user_mode_linux_howto_v2.rst: fix a
 literal block markup
References: <cover.1601616399.git.mchehab+huawei@kernel.org>
 <ce8a23cd0f138bd69ccc196e6dbe312da1044938.1601616399.git.mchehab+huawei@kernel.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4ba279b1-7119-e3a5-3b77-6751d5ec3221@cambridgegreys.com>
Date: Fri, 2 Oct 2020 08:38:54 +0100
MIME-Version: 1.0
In-Reply-To: <ce8a23cd0f138bd69ccc196e6dbe312da1044938.1601616399.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>



On 02/10/2020 06:49, Mauro Carvalho Chehab wrote:
> There's a missing new line for a literal block:
> 
> 	.../Documentation/virt/uml/user_mode_linux_howto_v2.rst:682: WARNING: Unexpected indentation.
> 
> Fixes: 04301bf5b072 ("docs: replace the old User Mode Linux HowTo with a new one")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   Documentation/virt/uml/user_mode_linux_howto_v2.rst | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/virt/uml/user_mode_linux_howto_v2.rst b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> index f70e6f5873c6..312e431695d9 100644
> --- a/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> +++ b/Documentation/virt/uml/user_mode_linux_howto_v2.rst
> @@ -679,6 +679,7 @@ Starting UML
>   
>   We can now run UML.
>   ::
> +
>      # linux mem=2048M umid=TEST \
>       ubd0=Filesystem.img \
>       vec0:transport=tap,ifname=tap0,depth=128,gro=1 \
> 

Thanks.

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

