Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUea-000148-8h
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:19:00 -0800
Received: from marasystems.com ([213.150.153.194] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATUeZ-0000iI-I6
	for user-mode-linux-devel@lists.sourceforge.net; Mon, 08 Dec 2003 15:18:59 -0800
From: Henrik Nordstrom <hno@marasystems.com>
Subject: Re: [uml-devel] [PATCH] Locking user-mode kernel RAM into host
 physical RAM
In-Reply-To: <200312082223.54582.matthew@bytemark.co.uk>
Message-ID: <Pine.LNX.4.44.0312090003010.14902-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 9 Dec 2003 00:18:55 +0100 (CET)
To: Matthew Bloch <matthew@bytemark.co.uk>
Cc: user-mode-linux-devel@lists.sourceforge.net

On Mon, 8 Dec 2003, Matthew Bloch wrote:

> Hi Jeff, I don't think this is true.  The 2.4 kernel does appear to swap out 
> applications when (e.g.) a large file copy is underway

Indeed. 2.4 will page out applications and application data if the memory
pressure for buffer/cache is larger than the pressure to use the memory bu
the applications (i.e. if the applications are idle), and it almost all
cases it should. This will include UML memory and kernel etc.  (well,
application binaries such as the UML kernel is not really paged out, but
their memory pages are reclaimed forcing them to be paged in again from
the program/library file)

> interactivity and vm patches", could you elaborate on that please Matt?  For 
> various reasons, we use a Redhat 2.4.20 kernel which I believe has had its 
> memory management fiddled with.

The RedHat 2.4.20 kernel has a completely different VM compared to stock
2.4.20 and behaves better in most aspects.

> That's my only argument as to why it should be included:  mlocked
> kernels behave more predictably in a hosting environment! 

In principle I agree, but it is somewhat of a corner case. For most
practical uses you should be able to get the same results with a correctly
tuned VM on the host and having sufficient amount of memory to allow for a
decent buffer/cache in addition to the UML memory usage. Only if you 
overbook the memory usage (including buffer/cache requirements on 
the host) should there be significant problems.

But as there is no thing such as a perfect VM which fits all, mlock of the
UML memory seems like a fair thing to do to the customer when the customer
pays per MB and the host is dedicated to UML hosting. But in most if not
all other situations it is plain bad and the wrong thing to do. If you
even dream about doing this you should never consider to allocate more
than 50% of the host memory or I/O performance will suffer a lot.

Regards
Henrik



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
