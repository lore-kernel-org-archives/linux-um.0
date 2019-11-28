Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from userp2120.oracle.com ([156.151.31.85])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iaFJg-0006MR-JF
 for linux-um@lists.infradead.org; Thu, 28 Nov 2019 08:38:25 +0000
Date: Thu, 28 Nov 2019 11:37:35 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH -next] um: vector: use GFP_ATOMIC under spin lock
Message-ID: <20191128083735.GE1781@kadam>
References: <20191128020147.191893-1-weiyongjun1@huawei.com>
 <20191128080641.GD1781@kadam>
 <5892ee7c-ff24-fb3c-6911-44e0b1d5895f@cambridgegreys.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5892ee7c-ff24-fb3c-6911-44e0b1d5895f@cambridgegreys.com>
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
Cc: Song Liu <songliubraving@fb.com>, Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, kernel-janitors@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, linux-um@lists.infradead.org, Wei Yongjun <weiyongjun1@huawei.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>

On Thu, Nov 28, 2019 at 08:18:30AM +0000, Anton Ivanov wrote:
> 
> 
> On 28/11/2019 08:06, Dan Carpenter wrote:
> > On Thu, Nov 28, 2019 at 02:01:47AM +0000, Wei Yongjun wrote:
> > > A spin lock is taken here so we should use GFP_ATOMIC.
> > > 
> > > Fixes: 9807019a62dc ("um: Loadable BPF "Firmware" for vector drivers")
> > > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> > > ---
> > >   arch/um/drivers/vector_kern.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> > > index 92617e16829e..6ff0065a271d 100644
> > > --- a/arch/um/drivers/vector_kern.c
> > > +++ b/arch/um/drivers/vector_kern.c
> > > @@ -1402,7 +1402,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
> > >   		kfree(vp->bpf->filter);
> > >   		vp->bpf->filter = NULL;
> > >   	} else {
> > > -		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_KERNEL);
> > > +		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_ATOMIC);
> > >   		if (vp->bpf == NULL) {
> > >   			netdev_err(dev, "failed to allocate memory for firmware\n");
> > >   			goto flash_fail;
> > > @@ -1414,7 +1414,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
> > >   	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
> >              ^^^^^^^^^^^^^^^^
> > 
> > Is it really possible to call request_firmware() while holding a
> > spin_lock?  I was so sure that read from the disk.
> 
> Works, I tested the patch quite a few times.
> 

Do you have CONFIG_DEBUG_ATOMIC_SLEEP enabled?  The GFP_KERNEL calls
should have triggered a warning if so.

regards,
dan carpenter


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

