Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KauVR-0000wC-Dv for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 08:42:53 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1KauVQ-0001AM-T5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 08:42:53 -0700
Date: Wed, 3 Sep 2008 08:42:49 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
Message-ID: <alpine.DEB.1.00.0809030833050.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
	<84144f020808300350i7cb2d23aj6d1ffcbeceaf7e9c@mail.gmail.com>
	<alpine.DEB.1.00.0809022036560.15543@abydos.NerdBox.Net>
	<84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
MIME-Version: 1.0
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, "Paul E. McKenney" <paulmck@us.ibm.com>, Ingo Molnar <mingo@elte.hu>, dkegel@google.com, jiayingz@google.com

Hello Pekka,

On Wed, 3 Sep 2008, Pekka Enberg wrote:

> On Wed, Sep 3, 2008 at 8:08 AM, Steve VanDeBogart
> <vandebo-lkml@nerdbox.net> wrote:
>> It is true that code above the allocator should not be touching free'd
>> slab objects.  However, it is also true that objects from slabs that
>> have a constructor should retain their per byte un/initialized state
>> through allocation and free cycles (just the semantic of slabs with
>> constructors AFAICT).
>
> Sorry for being unclear, sure, object should be marked as initialized
> when they're returned from kmem_cache_alloc(). However, what I
> disagree with is *where* you're marking them as initialized. Surely
> they're not semantically initialized when the slabs are allocated
> (although technically they are).

But which bits of a slab object should be marked as initialized at
kmem_cache_alloc() time?  We can't mark all of them as initialized
because the constructor may not initialize all of them (in fact, I've
programmatically confirmed that there are constructors that don't
initialize all the bytes of an object).  The only place to get the
information of interest is to mark all bytes uninitialized and then
run the constructor on the memory region.

>
> On Wed, Sep 3, 2008 at 8:08 AM, Steve VanDeBogart
> <vandebo-lkml@nerdbox.net> wrote:
>> Ideally, we'd tell Valgrind that the bytes of a free'd slab object are
>> no longer accessible, but the initialized state should remain the same
>> until the object is made accessible again by the next allocation of
>> the object.  Unfortunately, the compression method for A & V bits in
>> Valgrind doesn't allow a region to be inaccessible and retain validness
>> bits.
>
> I don't see why you should mark them initialized all the time. Just
> mark them as uninitialized on kmem_cache_free() and again as
> initialized when they're about to be returned from kmem_cache_alloc()
> like we do in kmemcheck.

This question has the same answer as above.

--
Steve

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
