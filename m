Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVUw6-0003Pz-B8	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 06:38:10 -0700
Received: from marasystems.com ([83.241.133.2] helo=filer.marasystems.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DVUw3-000212-3I	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 06:38:10 -0700
From: Henrik Nordstrom <uml@hno.marasystems.com>
Subject: Re: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix,
 for 2.6.12 ]
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0505101525360.16461@filer.marasystems.com>
References: <20050509224509.0C105416E4@zion>
	<20050509183401.28082cbc.akpm@osdl.org>
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
Date: Tue, 10 May 2005 15:37:33 +0200 (CEST)
To: Andrew Morton <akpm@osdl.org>
Cc: blaisorblade@yahoo.it, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Mon, 9 May 2005, Andrew Morton wrote:

>> diff -L include/asm-um/elf.h -puN include/asm-um/elf.h~uml-remove-elf-h /dev/null
>
> hmm, that's exciting.  How to tell diff and patch to remove a zero-length
> file?

This has to be instructed by the patch.. If the new file is an empty file 
with timestamp of 1 Jan 1970 then it is supposed to be deleted.

The /dev/null trick only works well for adding files, not removing them.

Regards
Henrik


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
