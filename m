Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jIfc5-0008FP-Qp
 for linux-um@lists.infradead.org; Sun, 29 Mar 2020 21:37:03 +0000
Received: by mail-wr1-x441.google.com with SMTP id t7so18808481wrw.12
 for <linux-um@lists.infradead.org>; Sun, 29 Mar 2020 14:37:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200219134442.68744-1-wenyang@linux.alibaba.com>
In-Reply-To: <20200219134442.68744-1-wenyang@linux.alibaba.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 29 Mar 2020 23:36:48 +0200
Message-ID: <CAFLxGvyZ3k=v0KWNn6GR9gqDsW5dz0F5CHo_4R11G+bUNaB2+Q@mail.gmail.com>
Subject: Re: [PATCH] um: fix len of file in create_pid_file
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Wen Yang <wenyang@linux.alibaba.com>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>, Alex Dewar <alex.dewar@gmx.co.uk>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Wed, Feb 19, 2020 at 2:45 PM Wen Yang <wenyang@linux.alibaba.com> wrote:
>
> sizeof gives us the size of the pointer variable, not of the
> area it points to. So the number of bytes copied by umid_file_name()
> is 8.
> We should pass in the correct length of the file buffer.
>
> Signed-off-by: Wen Yang <wenyang@linux.alibaba.com>
> Cc: Jeff Dike <jdike@addtoit.com> (maintainer:USER-MODE LINUX (UML))
> Cc: Richard Weinberger <richard@nod.at> (maintainer:USER-MODE LINUX (UML),commit_signer:2/2=100%)
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com> (maintainer:USER-MODE LINUX (UML))
> Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com> (commit_signer:1/2=50%,authored:1/2=50%,added_lines:27/28=96%,removed_lines:9/10=90%)
> Cc: Alex Dewar <alex.dewar@gmx.co.uk> (commit_signer:1/2=50%,authored:1/2=50%,removed_lines:1/10=10%)
> Cc: linux-um@lists.infradead.org (open list:USER-MODE LINUX (UML))
> ---
>  arch/um/os-Linux/umid.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/um/os-Linux/umid.c b/arch/um/os-Linux/umid.c
> index 44def53a11cd..9e16078a4bf8 100644
> --- a/arch/um/os-Linux/umid.c
> +++ b/arch/um/os-Linux/umid.c
> @@ -220,11 +220,12 @@ static void __init create_pid_file(void)
>         char pid[sizeof("nnnnn\0")], *file;
>         int fd, n;
>
> -       file = malloc(strlen(uml_dir) + UMID_LEN + sizeof("/pid\0"));
> +       n = strlen(uml_dir) + UMID_LEN + sizeof("/pid\0");
> +       file = malloc(n);
>         if (!file)
>                 return;
>
> -       if (umid_file_name("pid", file, sizeof(file)))
> +       if (umid_file_name("pid", file, n))
>                 goto out;
>

Good catch, applied.

-- 
Thanks,
//richard

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

