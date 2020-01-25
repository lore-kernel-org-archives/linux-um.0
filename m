Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from aserp2120.oracle.com ([141.146.126.78])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ivEX1-0001qL-B1
 for linux-um@lists.infradead.org; Sat, 25 Jan 2020 06:02:56 +0000
Date: Sat, 25 Jan 2020 09:01:52 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] um: Fix some error handling in uml_vector_user_bpf()
Message-ID: <20200125060152.GN1847@kadam>
References: <20200124101450.jxfzsh6sz7v324hv@kili.mountain>
 <36070c96-8e75-7d06-d945-87a9d366d0b9@cambridgegreys.com>
 <20200124164427.GF1870@kadam>
 <de3bdae8-2dcd-490f-cdf2-67bf92a552e8@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <de3bdae8-2dcd-490f-cdf2-67bf92a552e8@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: kernel-janitors@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Song Liu <songliubraving@fb.com>, Alexei Starovoitov <ast@kernel.org>, Alex Dewar <alex.dewar@gmx.co.uk>, Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org, Andrii Nakryiko <andriin@fb.com>, Martin KaFai Lau <kafai@fb.com>

On Fri, Jan 24, 2020 at 04:48:03PM +0000, Anton Ivanov wrote:
> 
> 
> On 24/01/2020 16:44, Dan Carpenter wrote:
> > On Fri, Jan 24, 2020 at 12:52:18PM +0000, Anton Ivanov wrote:
> > > 
> > > 
> > > On 24/01/2020 10:14, Dan Carpenter wrote:
> > > > 1) The uml_vector_user_bpf() returns pointers so it should return NULL
> > > >      instead of false.
> > > > 2) If the "bpf_prog" allocation failed, it would have eventually lead to
> > > >      a crash.  We can't succeed after the error happens so it should just
> > > >      return.
> > > > 
> > > > Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > ---
> > > >    arch/um/drivers/vector_user.c | 10 +++++-----
> > > >    1 file changed, 5 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> > > > index ddcd917be0af..88483f5b034c 100644
> > > > --- a/arch/um/drivers/vector_user.c
> > > > +++ b/arch/um/drivers/vector_user.c
> > > > @@ -732,13 +732,13 @@ void *uml_vector_user_bpf(char *filename)
> > > >    	if (stat(filename, &statbuf) < 0) {
> > > >    		printk(KERN_ERR "Error %d reading bpf file", -errno);
> > > > -		return false;
> > > > +		return NULL;
> > > 
> > > I will sort this one out, thanks for noticing.
> > > 
> > > >    	}
> > > >    	bpf_prog = uml_kmalloc(sizeof(struct sock_fprog), UM_GFP_KERNEL);
> > > > -	if (bpf_prog != NULL) {
> > > > -		bpf_prog->len = statbuf.st_size / sizeof(struct sock_filter);
> > > > -		bpf_prog->filter = NULL;
> > > > -	}
> > > > +	if (!pfg_prog)
> > > 
> > > ^^^^^ ?
> > 
> > If we don't return here it leads to a NULL dereference.
> 
> It says pfg_prog
> 
> I cannot find this identifier :)
> 

Oh wow...  That's very embarrassing.  My QC scripts do compile these
as part of the process.  But this wasn't a in of my allmodconfig
and when I do "make arch/um/drivers/vector_user.o", it just silently
returns without printing anything.  I didn't notice that it hadn't
built.

Even "make V=2 arch/um/drivers/vector_user.o" doesn't generate output.

I will resend the patch (on Monday though).

regards,
dan carpenter

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

