Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Nicholas Nethercote <njn25@cam.ac.uk>
Subject: Re: [Valgrind-users] Re: [uml-devel] Re: UML and valgrind 
In-Reply-To: <200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.60.0408032300130.23352@hermes-1.csi.cam.ac.uk>
References: <C28780ABC637504896EB86B4FB75FFBFA26E5E@MAANDMBX1.ets.enterasys.com>
	<410EFCDB.8080404@enterasys.com>
	<200408030517.i735HZUE026250@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031028541.22157@hermes-1.csi.cam.ac.uk>
	<200408031450.i73EoEvv002040@ccure.user-mode-linux.org>
	<Pine.LNX.4.60.0408031527320.22157@hermes-1.csi.cam.ac.uk>
	<200408031750.i73HoMvv002966@ccure.user-mode-linux.org>
	<410FCC70.1050902@enterasys.com>
	<200408031931.i73JVkvv003367@ccure.user-mode-linux.org>
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
Date: Tue, 3 Aug 2004 23:04:47 +0100 (BST)
To: Jeff Dike <jdike@addtoit.com>
Cc: "D. Bahi" <dbahi@enterasys.com>, user-mode-linux-devel@lists.sourceforge.net, valgrind-users@lists.sourceforge.net

On Tue, 3 Aug 2004, Jeff Dike wrote:

>> +       pushl   %eax
>> +       movl    VG_(m_state_static)+60, %eax
>> +       movl    %eax, save_ip
>> +       popl    %eax

m_state_static doesn't exist anymore.  You could try getting the simulated 
%eip out of the 'baseBlock' -- it starts at VG_(baseBlock), and %eip is 
VGOFF_(m_eip) *words* into it, ie. 4*VGOFF_(m_eax) bytes into it.  I'm not 
certain that the simulated %eip is up-to-date exactly as necessary, but it 
could be.  The rest of the patch would work the same way.

> Also, I saw this:
>
>> 	valgrind: the `impossible' happened:
>> 	   Unhandled REPE case
>
> If you see this, check that you have
> 	http://www.goop.org/~jeremy/valgrind/76-repe-scas.patch
> and apply if not.

That should be fixed in all recent versions of Valgrind.

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
