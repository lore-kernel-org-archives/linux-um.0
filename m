Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMHHN-001uCX-3f
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 21:31:08 +0000
Message-ID: <87933c0d6c07745b20f6724721e3bf2da8f67f72.camel@sipsolutions.net>
Subject: Re: [RFC v8 08/20] um: lkl: memory handling
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 16 Mar 2021 22:31:03 +0100
In-Reply-To: <m28s6nc2w1.wl-thehajime@gmail.com>
 (sfid-20210316_021825_898828_61B64BB2)
References: <cover.1611103406.git.thehajime@gmail.com>
 <19d4990f2ef77ad595248183071da5e43149931c.1611103406.git.thehajime@gmail.com>
 <03c74a353c87994b61450ba8086f1ccda40b2ea8.camel@sipsolutions.net>
 <m28s6nc2w1.wl-thehajime@gmail.com> (sfid-20210316_021825_898828_61B64BB2)
MIME-Version: 1.0
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

On Tue, 2021-03-16 at 10:18 +0900, Hajime Tazaki wrote:
> 
> > > +void *uml_kmalloc(int size, int flags)
> > > +{
> > > +	return kmalloc(size, flags);
> > > +}
> > 
> > That could probably still be shared?
> 
> This function is a stub of arch/um/kernel/mem.c, which LKL doesn't
> use for the build.  Thus we defined here.
> 
> Or are you suggesting to not stubbing this function, but extracting
> the function from mem.c ?

Yes, that's kind of what I was thinking.

OTOH, I guess it's in os-Linux today?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

