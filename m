Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BkXNH-0006YB-NW for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 17:11:51 -0700
Received: from gort.metaparadigm.com ([203.117.131.12])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BkXNH-0002fw-9S for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 13 Jul 2004 17:11:51 -0700
Message-ID: <40F47A3C.3040301@metaparadigm.com>
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] make port channel use setsockopt SO_REUSEADDR
References: <40EA8869.8050602@metaparadigm.com>
	<200407131905.i6DJ5gGu003363@ccure.user-mode-linux.org>
In-Reply-To: <200407131905.i6DJ5gGu003363@ccure.user-mode-linux.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 14 Jul 2004 08:11:40 +0800
To: Jeff Dike <jdike@addtoit.com>
Cc: UML Devel <user-mode-linux-devel@lists.sourceforge.net>

On 07/14/04 03:05, Jeff Dike wrote:
> michael@metaparadigm.com said:
> 
>>Small patch to make port channels allow reuse of local addresses.
>>Useful in the case where you restart a UML from a script and you don't
>>want to have to allocate a new port number each time. 
> 
> 
> Applied, except I fixed the error case slightly.

Ooops, yes, my bad. leaking fd.

Thanks,
~mc


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
