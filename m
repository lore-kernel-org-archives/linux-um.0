Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kakru-0001sH-LM for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 22:25:26 -0700
Received: from abydos.nerdbox.net ([216.151.149.55])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Kakrt-00079l-DI
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 02 Sep 2008 22:25:26 -0700
Date: Tue, 2 Sep 2008 22:25:21 -0700 (PDT)
From: Steve VanDeBogart <vandebo-lkml@NerdBox.Net>
In-Reply-To: <84144f020808300357l9dddda4y726622641ac7f592@mail.gmail.com>
Message-ID: <alpine.DEB.1.00.0809022209100.15543@abydos.NerdBox.Net>
References: <alpine.DEB.1.00.0808281139420.15543@abydos.NerdBox.Net>
	<alpine.DEB.1.00.0808291616170.15543@abydos.NerdBox.Net>
	<84144f020808300357l9dddda4y726622641ac7f592@mail.gmail.com>
MIME-Version: 1.0
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
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, jiayingz@google.com, dkegel@google.com

On Sat, 30 Aug 2008, Pekka Enberg wrote:

> Hi Steve,
>
> On Sat, Aug 30, 2008 at 2:16 AM, Steve VanDeBogart
> <vandebo-lkml@nerdbox.net> wrote:
>> Valgrind annotations for valgrind: memory is addressable once it's been
>> alloced, and unaddressable when it is freed again.  Can't use malloc-like
>> and free-like because valgrind considers a malloc-like chunk indivisible.
>>
>> Signed-off-by: Steve VanDeBogart <vandebo-lkml@nerdbox.net>
>> ---
>>
>> Index: linux-2.6.27-rc5/mm/page_alloc.c
>> @@ -1080,6 +1081,7 @@
>>                if (!page)
>>                        goto failed;
>>        }
>> +       VALGRIND_MAKE_MEM_UNDEFINED(page_address(page), PAGE_SIZE << order);
>
> No SHOUTING macros please, and I think you should just pass page and
> order here and do the calculation elsewhere.

Valgrind provides a header file that defines these annotation functions.
For the ease of tracking changes to this header file, I've made minimal
changes to it (just a couple lines to integrate with Kconfig).  If the
interfaces and/or style is objectionable to the kernel community at
large, than we will have to decide to either wrap the interface that
Valgrind provides or modify the header and track changes manually.

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
