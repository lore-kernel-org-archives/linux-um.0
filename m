Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1klpoA-00075k-Ik
 for linux-um@lists.infradead.org; Sun, 06 Dec 2020 08:54:19 +0000
Message-ID: <b9c9db94168d96026c323dfb256500ac42e7024b.camel@sipsolutions.net>
Subject: Re: [PATCH 2/2] um: allocate a guard page to helper threads
From: Johannes Berg <johannes@sipsolutions.net>
Date: Sun, 06 Dec 2020 09:53:59 +0100
In-Reply-To: <c0d2af57-3db9-09e7-8d9a-813018529174@cambridgegreys.com>
References: <20201205215016.eac3b08ee1a2.I47d69ccd6a474726b83813c60a75aa82556b69ae@changeid>
 <20201205215016.c9770d63195d.I816f5a22bff56c55095e7c847df8449d08e9514c@changeid>
 <20f9d000-d4a9-59cc-9dba-9673d9185def@cambridgegreys.com>
 <63dd29aaceeef43e15f42aaf4de45a9093812116.camel@sipsolutions.net>
 <c0d2af57-3db9-09e7-8d9a-813018529174@cambridgegreys.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

On Sun, 2020-12-06 at 08:23 +0000, Anton Ivanov wrote:
> On 06/12/2020 08:11, Johannes Berg wrote:
> > On Sat, 2020-12-05 at 22:09 +0000, Anton Ivanov wrote:
> > 
> > > > -unsigned long alloc_stack(int order, int atomic)
> > > > +unsigned long alloc_stack(int atomic)
> > > >    {
> > > > -	unsigned long page;
> > > > +	unsigned long addr;
> > > >    	gfp_t flags = GFP_KERNEL;
> > > >    
> > > >    	if (atomic)
> > > >    		flags = GFP_ATOMIC;
> > > > -	page = __get_free_pages(flags, order);
> > > > +	addr = __get_free_pages(flags, 1);
> > > Why are you dropping order?
> > It was always called with 0 as the order argument, so I didn't think it
> > was relevant. I guess we can keep it and allocate order+1, and then
> > reserve a page, but if then e.g. you wanted order 2 (16k) you'd actually
> > get 28k of usable stack and use up 32k. So I thought it was less
> > surprising if we'd remove it.
> > 
> > > I believe we do not fit in a stack of order
> > > less than 2 on newer 64 bit and we need even more with valgrind.
> > Not sure what you mean by this, tbh. Running the whole of UML in
> > valgrind? Why would that require more stack?
> 
> According to the description of the stack order option in the config it 
> does.

Ah ok, you're referring to CONFIG_KERNEL_STACK_ORDER. That indeed
affects only *kernel* threads, not the helper threads that are allocated
here.

Not sure why valgrind would matter, but perhaps it does some magic with
stacks under the hood, don't really know well what it really does.

> > Kernel threads are
> > unaffected, and the helper threads don't do much that would really make
> > a significant difference between 32 and 64 bit?
> 
> OK, I need to have a look again on where do we use the order parameter 
> and what that config option really means.

Well, it affects THREAD_SIZE_ORDER, which is used in kernel/fork.c to
allocate the kernel stacks for new threads, so that makes sense.

But the code I changed here has no relation to it, it's just for the
userspace helper threads such as winch_thread :)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

