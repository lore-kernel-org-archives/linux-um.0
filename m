Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Nicholas Nethercote <njn25@cam.ac.uk>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: <200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk> 
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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
Date: Tue, 3 Aug 2004 15:31:44 +0100 (BST)
To: Jeff Dike <jdike@addtoit.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

On Tue, 3 Aug 2004, Jeff Dike wrote:

>> What address was UML trying to load something at?
>
> 0xa0000000

Currently Valgrind uses 0xb0000000--0xbfffffff for itself, always.  Below 
that depends which tool you are using, if it uses "shadow memory" (ie. 
shadowing every memory value with a metavalue), and how big the shadow 
metavalues are.

For example, Memcheck uses 9 bits of shadow memory for every byte of real 
memory, so it reserves down to 0x52c00000 or so for its own use.  If you 
try Addrcheck, which only uses 1 shadow bit per real byte, it will reserve 
down to only about 0x9c000000.  If you use --tool=none, no shadow memory 
is needed so you should be able to use up to about 0xaf000000.

HTH

N


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
