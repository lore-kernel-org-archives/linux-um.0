Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-list2-new-b.sourceforge.net ([10.3.1.94]
	helo=sc8-sf-list2-new.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7xcy-0006vq-Qf for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 10:38:45 -0800
Message-ID: <4773F11D.7060803@BitWagon.com>
Date: Thu, 27 Dec 2007 10:38:21 -0800
From: John Reiser <jreiser@BitWagon.com>
MIME-Version: 1.0
Subject: [uml-devel] running UserModeLinux under Valgrind(memcheck)
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
To: user-mode-linux-devel@lists.sourceforge.net, valgrind-developers@lists.sourceforge.net

Patches have been developed which enable UserModeLinux for i686 to
run under the memcheck tool of Valgrind on i686.  Thus it is possible
to check dynamically the memory accesses made by a running Linux kernel
against memcheck's model of allowed behavior.  This work was supported
by Google Inc.

The combined patches are at "alpha" quality.  They have memchecked
an entire trivial session (boot UML, login, halt), and have identified
a couple specific problems in kernel code.  The steps necessary to reach
"beta" quality (a motivated kernel developer can get useful results)
have been outlined and are being pursued.

The goods:
 15KB  http://bitwagon.com/valgrind+uml/valgrind-3.3.0-2007-12-27.patch.gz
 60KB  http://bitwagon.com/valgrind+uml/uml-2.6.22.5-2007-12-27.patch.gz

Current status and updates will be maintained on the [coming] web page
       http://bitwagon.com/valgrind+uml/index.html

As a convenience for when the official sites are not responding,
here are copies of the original unpatched software that is required:
  4MB  http://bitwagon.com/valgrind+uml/valgrind-3.3.0.tar.bz2
 45MB  http://bitwagon.com/valgrind+uml/linux-2.6.22.5.tar.bz2
103MB  http://bitwagon.com/valgrind+uml/FedoraCore5-x86-root_fs.bz2
Approximately 2.5GB of disk space is required to play.

Motivated in part by the difficulty of tracking down the causes of
"Conditional jump or move depends on uninitialised data", the patches
include a new *optional* mode for memcheck: --complain-asap=yes.
In this mode, memcheck issues a complaint immediately for any load
from memory that contains uninitialized bits.  This gives a very early
notice of potential trouble.  It also squawks for uninitialized
holes in structures or bitfields, conditions which later become ignored
or "don't care", certain compiler optimizations for speed, etc.
The intent is to reduce the blizzard of "false positive" complaints
by using the glibc-audit patches to provide a "quiet" glibc,
by making the holes in kernel structures explicit (and filling them),
by writing suppressions for known cases, by and further enhancing
this new mode of memcheck.

On the UML side, there is a significant technical issue: the semantics
of kmalloc+kfree do not match the semantics of malloc+free.  The kernel
slab allocator caches and re-issues identified objects, which accumulate
state and retain it throughout execution, including from kfree to kmalloc.
In contrast, a region that is passed to free() loses both its contents
and its identity.  Also, size is an important parameter to malloc,
but is implicit to kmalloc.  The initial patches finesse these issues
(for instance: by supplying the size as trailing parameter to kmalloc,
and by noticing that SLAB_POISON ==> free()), but there will be
significant discussion and work in resolving the differences.

-- 
John Reiser, jreiser@BitWagon.com

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
