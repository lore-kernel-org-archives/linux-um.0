Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kb9Lp-0000ol-8V for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:33:57 -0700
Received: from rv-out-0708.google.com ([209.85.198.250])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kb9Ln-00058k-2b
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 04 Sep 2008 00:33:57 -0700
Received: by rv-out-0708.google.com with SMTP id f25so2563106rvb.22
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Thu, 04 Sep 2008 00:33:54 -0700 (PDT)
Message-ID: <84144f020809040033h6872ecfdlfb7d7cdb57621b0d@mail.gmail.com>
Date: Thu, 4 Sep 2008 10:33:54 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <alpine.DEB.1.00.0809030833050.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Disposition: inline
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616560.15543@abydos.NerdBox.Net>
	<84144f020808300350i7cb2d23aj6d1ffcbeceaf7e9c@mail.gmail.com>
	<alpine.DEB.1.00.0809022036560.15543@abydos.NerdBox.Net>
	<84144f020809030227jce7d3c2wab9e9c00b2fcdfe5@mail.gmail.com>
	<alpine.DEB.1.00.0809030833050.15543@abydos.NerdBox.Net>
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

On Wed, Sep 3, 2008 at 6:42 PM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
> But which bits of a slab object should be marked as initialized at
> kmem_cache_alloc() time?  We can't mark all of them as initialized
> because the constructor may not initialize all of them (in fact, I've
> programmatically confirmed that there are constructors that don't
> initialize all the bytes of an object).  The only place to get the
> information of interest is to mark all bytes uninitialized and then
> run the constructor on the memory region.

Aah, indeed. We should fix kmemcheck as well then.

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
