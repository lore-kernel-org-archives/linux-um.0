Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CWYKu-0002pp-Kk for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 02:55:52 -0800
Received: from [80.71.3.50] (helo=titan.server-plant.co.uk)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CWYKs-0002vm-BQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Nov 2004 02:55:52 -0800
Message-ID: <32983.217.46.152.98.1101207349.squirrel@217.46.152.98>
In-Reply-To: <32863.217.46.152.98.1101201072.squirrel@217.46.152.98>
References: <32863.217.46.152.98.1101201072.squirrel@217.46.152.98>
Subject: Re: [uml-devel] Kernel BUG in host
From: "Leigh Brown" <leigh@solinno.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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
Date: Tue, 23 Nov 2004 10:55:49 -0000 (GMT)
To: ML-uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Leigh Brown said:
> The host is running Debian Sarge 2.6.8.1 kernel patched with
> host-skas3-2.6.7-v7.patch.  The guest is running Debian Sarge
> 2.4.26-um3.  I'm seeing this kernel bug in the host after one
> or two days running:
>
> kernel BUG at mm/mmap.c:337!
> invalid operand: 0000 [#1]
> PREEMPT SMP
[...]

Okay, I'm going to build a non-preempt kernel.  Has anyone else had
problems with preempt in the host?

Cheers,

Leigh.



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
