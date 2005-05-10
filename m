Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVJdv-0007bo-6c	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 18:34:39 -0700
Received: from fire.osdl.org ([65.172.181.4] helo=smtp.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)	id 1DVJdt-00037v-2D
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 09 May 2005 18:34:39 -0700
From: Andrew Morton <akpm@osdl.org>
Message-Id: <20050509183401.28082cbc.akpm@osdl.org>
In-Reply-To: <20050509224509.0C105416E4@zion>
References: <20050509224509.0C105416E4@zion>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: [uml-devel] Re: [patch 1/6] uml: remove elf.h [ compile-fix, for
	2.6.12 ]
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
Date: Mon, 9 May 2005 18:34:01 -0700
To: blaisorblade@yahoo.it
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

blaisorblade@yahoo.it wrote:
>
> 
> Actually remove elf.h in the tree. The previous patch, due to a quilt
> bug/misuse, left it in the tree as a 0-length file, preventing the build to
> see it as missing and to generate a symlink in its place.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> ---
> 
>   |    0 
>  1 files changed
> 
> diff -L include/asm-um/elf.h -puN include/asm-um/elf.h~uml-remove-elf-h /dev/null

hmm, that's exciting.  How to tell diff and patch to remove a zero-length
file?

bix:/home/akpm> mkdir a b
bix:/home/akpm> touch a/a
bix:/home/akpm> diff -uNr a b
bix:/home/akpm> diff -u a b  
Only in a: a
bix:/home/akpm> diff -ur a b
Only in a: a
bix:/home/akpm> diff -uPr a b
Only in a: a

I'll just ask Linus to delete it ;)


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
