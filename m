Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jitgG-00053N-AL
 for linux-um@lists.infradead.org; Wed, 10 Jun 2020 05:53:45 +0000
Date: Wed, 10 Jun 2020 07:53:39 +0200
From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] Fix null pointer dereference in vector_user_bpf
Message-ID: <20200610055339.GA1865470@kroah.com>
References: <20200610034314.9290-1-gaurav1086@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200610034314.9290-1-gaurav1086@gmail.com>
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
To: Gaurav Singh <gaurav1086@gmail.com>
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, open list <linux-kernel@vger.kernel.org>, "open list:USER-MODE LINUX (UML)" <linux-um@lists.infradead.org>, "open list:BPF (Safe dynamic programs and tools)" <netdev@vger.kernel.org>, Alex Dewar <alex.dewar@gmx.co.uk>, KP Singh <kpsingh@chromium.org>, Yonghong Song <yhs@fb.com>, "open list:BPF (Safe dynamic programs and tools)" <bpf@vger.kernel.org>, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

On Tue, Jun 09, 2020 at 11:43:00PM -0400, Gaurav Singh wrote:
> Signed-off-by: Gaurav Singh <gaurav1086@gmail.com>
> 
> The bpf_prog is being checked for !NULL after uml_kmalloc but
> later its used directly for example: 
> bpf_prog->filter = bpf and is also later returned upon success.
> Fix this, do a NULL check and return right away.
> 
> ---
>  arch/um/drivers/vector_user.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

No signed-off-by?

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

