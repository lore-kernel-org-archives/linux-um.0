Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaodu-0001jd-2G for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:27:14 -0700
Received: from wa-out-1112.google.com ([209.85.146.179])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kaods-0004lo-O6
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:27:14 -0700
Received: by wa-out-1112.google.com with SMTP id j5so2261845wah.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Sep 2008 02:27:12 -0700 (PDT)
Message-ID: <84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
Date: Wed, 3 Sep 2008 12:27:12 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <alpine.DEB.1.00.0809022036560.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Disposition: inline
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
	<84144f020808300350i7cb2d23aj6d1ffcbeceaf7e9c@mail.gmail.com>
	<alpine.DEB.1.00.0809022036560.15543@abydos.NerdBox.Net>
Subject: Re: [uml-devel] [PATCH 5/6] slab: Annotate slab
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, dkegel@google.com, jiayingz@google.com

Hi Steve,

On Wed, Sep 3, 2008 at 8:08 AM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
> Thank you for pointing out the location of the kmemcheck code.  I looked
> around briefly but didn't find the latest version.  It does seem that
> kmemcheck and Valgrind annotations want to live in the same places so it
> makes perfect sense to combine them where possible.  I'm not exactly sure
> what you find so ugly about the Valgrind annotations, please elaborate.

Upper case macros and littering #ifdefs in the code. See the kmemcheck
hooks how to do it in a clean way.

On Wed, Sep 3, 2008 at 8:08 AM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
> It is true that code above the allocator should not be touching free'd
> slab objects.  However, it is also true that objects from slabs that
> have a constructor should retain their per byte un/initialized state
> through allocation and free cycles (just the semantic of slabs with
> constructors AFAICT).

Sorry for being unclear, sure, object should be marked as initialized
when they're returned from kmem_cache_alloc(). However, what I
disagree with is *where* you're marking them as initialized. Surely
they're not semantically initialized when the slabs are allocated
(although technically they are).

On Wed, Sep 3, 2008 at 8:08 AM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
> Ideally, we'd tell Valgrind that the bytes of a free'd slab object are
> no longer accessible, but the initialized state should remain the same
> until the object is made accessible again by the next allocation of
> the object.  Unfortunately, the compression method for A & V bits in
> Valgrind doesn't allow a region to be inaccessible and retain validness
> bits.

I don't see why you should mark them initialized all the time. Just
mark them as uninitialized on kmem_cache_free() and again as
initialized when they're about to be returned from kmem_cache_alloc()
like we do in kmemcheck.

                              Pekka

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
