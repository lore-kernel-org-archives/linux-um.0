Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJGHn-0001ZF-IU for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:33:59 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DJGHn-0006qR-3J for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 06 Apr 2005 12:33:59 -0700
Message-ID: <425439A4.2030006@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
	<20050406191623.GA10085@wavehammer.waldi.eu.org>
In-Reply-To: <20050406191623.GA10085@wavehammer.waldi.eu.org>
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
Date: Wed, 06 Apr 2005 21:33:56 +0200
To: Bastian Blank <bastian@waldi.eu.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Bastian Blank wrote:
> On Wed, Apr 06, 2005 at 04:35:58PM -0400, Jeff Dike wrote:
> 
>>I merged these, except for the restartnointr one because I don't have
>>ERESTARTNOINTR in my /usr/include, inside a #ifdef KERNEL or not.
> 
> 
> 2.6.11 shows:
> 
> | $ grep ERESTARTNOINTR -r .
> | ./linux/errno.h:#define ERESTARTNOINTR  513
> 
> And it is there since 2.5.
> 
> Bastian
> 
TX for the info, but sorry, I guess you missunderstood. We were not talking
about kernel's include/linux/errno.h, but about host's /usr/include/linux/errno.h,
included in a user-obj in UML. Even kernel 2.4 defines ERESTARTNOINTR,
but there seem to be some distros, that don't have it in /usr/include/linux/errno.h.
And I really wanted to have host's ERESTARTNOINTR!

	Bodo


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
