Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp 
	(Cipher TLSv1:DES-CBC3-SHA:168) (Exim 3.31-VA-mm2 #1 (Debian))
	id 19zIhh-0004bp-00
	for <User-mode-linux-devel@lists.sourceforge.net>; Tue, 16 Sep 2003 09:29:25 -0700
Received: from hermes.dur.ac.uk ([129.234.4.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.22)
	id 19zIhg-0002pL-Nu
	for User-mode-linux-devel@lists.sourceforge.net; Tue, 16 Sep 2003 09:29:24 -0700
From: M A Young <m.a.young@durham.ac.uk>
In-Reply-To: <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk>
Message-ID: <Pine.GSO.4.53.0309161720480.4325@algedi.dur.ac.uk>
References: <Pine.GSO.4.53.0309102139120.9641@altair.dur.ac.uk>
 <Pine.GSO.4.53.0309122031300.4368@altair.dur.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [uml-devel] Re: uml segfaults on redhat beta "severn"
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 16 Sep 2003 17:28:54 +0100 (BST)
To: User-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com

On Fri, 12 Sep 2003, M A Young wrote:

> On Wed, 10 Sep 2003, M A Young wrote:
>
> > If you try to run a uml kernel under a 2.4 kernel from the redhat beta
> > "severn" in tt mode, you get an almost immediate crash, under
> > before_mem_tt, in the final remap_data call. The problem is that it seem
> > in these kernels, maybe as a result of the new "exec-shield" feature, that
> > the code and data segments are no longer adjacent, which means that from
> > __bss_start to sbrk(0) is around 26Mb rather than under 1Mb, including
> > bits it presumably has no right to copy, hence the segfault.
> > This will presumably also apply to Red Hat's next release, assuming they
> > keep the same features.

The exec-shield code appears to have been modified in the latest redhat
beta kernel with the result that uml kernels no longer crash - presumably
the memory allocations aren't stirred up quite so much. Hence patching
this problem may now be unnecessary.

	Michael Young


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
