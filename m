Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DJTUb-00056N-81 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 02:40:05 -0700
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DJTUZ-0006PY-HF for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 07 Apr 2005 02:40:05 -0700
Message-ID: <4254FFEF.1020900@fujitsu-siemens.com>
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] Re: UML-patches to prepare UML/s390
References: <4253E3D6.2000809@fujitsu-siemens.com>
	<20050406203558.GA3307@ccure.user-mode-linux.org>
	<20050406191623.GA10085@wavehammer.waldi.eu.org>
	<425439A4.2030006@fujitsu-siemens.com>
	<20050406200257.GB24438@wavehammer.waldi.eu.org>
In-Reply-To: <20050406200257.GB24438@wavehammer.waldi.eu.org>
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
Date: Thu, 07 Apr 2005 11:39:59 +0200
To: Bastian Blank <bastian@waldi.eu.org>
Cc: user-mode-linux-devel@lists.sourceforge.net

Bastian Blank wrote:
> But anyway, this errno is internal.  So there exists
> no "host's ERESTARTNOINTR".
As Blaisorblade pointed out, ptrace interface also is
part of the ABI. User programs using ptrace *can* see
ERESTARTNOINTR and all the other ERESTARTXXXX.
So there exists "host's ERESTARTNOINTR", but sometimes it's
missing in the headers.
See, what strace-programmers do in syscall.c to define the
possibly missing ERESTARTXXXX macros.
We will have to do something similar in UML.

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
