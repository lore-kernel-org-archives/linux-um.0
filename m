Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DVRyH-0005ax-IR	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 03:28:13 -0700
Received: from smtp002.mail.ukl.yahoo.com ([217.12.11.33])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DVRyB-0003Pr-V5	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 10 May 2005 03:28:13 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
References: <20050509224509.0C105416E4@zion>
	<20050509183401.28082cbc.akpm@osdl.org>
In-Reply-To: <20050509183401.28082cbc.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505101216.59293.blaisorblade@yahoo.it>
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
Date: Tue, 10 May 2005 12:16:58 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

On Tuesday 10 May 2005 03:34, Andrew Morton wrote:
> blaisorblade@yahoo.it wrote:
> > Actually remove elf.h in the tree. The previous patch, due to a quilt
> > bug/misuse, left it in the tree as a 0-length file, preventing the build
> > to see it as missing and to generate a symlink in its place.

Ok, I was confused by the fact that with patch-scripts, which you use, it 
works, and thought it was patch to make it work.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7393&alloc_id=16281&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
