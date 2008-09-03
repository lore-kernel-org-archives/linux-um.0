Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kaom9-0002YW-AJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:35:45 -0700
Received: from wa-out-1112.google.com ([209.85.146.178])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kaom7-00045L-Uz
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 02:35:45 -0700
Received: by wa-out-1112.google.com with SMTP id j5so2263948wah.18
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 03 Sep 2008 02:35:43 -0700 (PDT)
Message-ID: <84144f020809030235p14f71915v355102005add6c5a@mail.gmail.com>
Date: Wed, 3 Sep 2008 12:35:43 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
In-Reply-To: <alpine.DEB.1.00.0809022209100.15543@abydos.NerdBox.Net>
MIME-Version: 1.0
Content-Disposition: inline
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616170.15543@abydos.NerdBox.Net>
	<84144f020808300357l9dddda4y726622641ac7f592@mail.gmail.com>
	<alpine.DEB.1.00.0809022209100.15543@abydos.NerdBox.Net>
Subject: Re: [uml-devel] [PATCH 4/6] VM: Annotate pagealloc
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
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, dkegel@google.com, jiayingz@google.com

Hi Steve,

On Wed, Sep 3, 2008 at 8:25 AM, Steve VanDeBogart
<vandebo-lkml@nerdbox.net> wrote:
>>> Index: linux-2.6.27-rc5/mm/page_alloc.c
>>> @@ -1080,6 +1081,7 @@
>>>               if (!page)
>>>                       goto failed;
>>>       }
>>> +       VALGRIND_MAKE_MEM_UNDEFINED(page_address(page), PAGE_SIZE <<
>>> order);
>>
>> No SHOUTING macros please, and I think you should just pass page and
>> order here and do the calculation elsewhere.
>
> Valgrind provides a header file that defines these annotation functions.
> For the ease of tracking changes to this header file, I've made minimal
> changes to it (just a couple lines to integrate with Kconfig).  If the
> interfaces and/or style is objectionable to the kernel community at
> large, than we will have to decide to either wrap the interface that
> Valgrind provides or modify the header and track changes manually.

That's trivially fixable by adding a wrapper for the ugly valgrind
macros and hiding that in some header file. Preferably something
similar to what the kmemcheck hooks look like so that we can also use
them in the future if we implement tracking at page allocator level
too.

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
