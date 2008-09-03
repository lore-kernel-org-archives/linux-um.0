Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaor7-000359-K8 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:40:53 -0700
Received: from rv-out-0708.google.com ([209.85.198.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kaor6-00064d-A3
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:40:53 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2161909rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Sep 2008 02:40:51 -0700 (PDT)
Message-ID: <84144f020809030240l265891e8gad5a2a9fced6880f@mail.gmail.com>
Date: Wed, 3 Sep 2008 12:40:51 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
	<84144f020808300350i7cb2d23aj6d1ffcbeceaf7e9c@mail.gmail.com>
	<alpine.DEB.1.00.0809022036560.15543@abydos.NerdBox.Net>
	<84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
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

On Wed, Sep 3, 2008 at 12:27 PM, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
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

Btw, actually, we don't mark them as uninitialized at the moment, but
that's a bug in kmemcheck.

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
