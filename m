Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B8Nm6-0002tf-4r for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 10:15:46 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B8Nm5-0001M3-Hs for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 30 Mar 2004 10:15:45 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403302025.02276.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] Vmlinux - linux linking stages & /proc/kallsyms empty
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
Date: Tue, 30 Mar 2004 19:25:02 +0100
To: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>

Jeff, is there any good reason to first link everything in vmlinux and then 
link things properly in linux? Because I have reasons (i.e. bugs) against 
this.

--THE BUGS
**Symptom: /proc/kallsyms is empty. Any stack dump cannot contain the symbol 
names.

**Reason: This because the vmlinux link script is wrong (you rejected the 
patch I sent you time ago, was in the patchset). But kallsyms must contain 
the true addresses of the kernel symbols; since they change between vmlinux 
and linux (if they didn't change, the second step would be useless), they 
cannot be correct. I think that even System.map symbols do not match.

**Fix: So, we actually need to make vmlinux have the correct addresses, i.e. 
avoid the two-pass linking.

--HOW TO FIX THIS: 
You specify the -r flags for vmlinux, so you could as well pass the extra 
objects in and the right link script.

--WHY SHOULD WE BOTHER?
Because it is a fix and it is easy to fix.

Any comments?
-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
