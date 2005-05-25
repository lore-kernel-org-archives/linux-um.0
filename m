Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DakgV-0003Lq-83	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2005 18:27:47 -0700
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DakgS-0007Ym-CE	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 May 2005 18:27:47 -0700
From: Blaisorblade <blaisorblade@yahoo.it>
Subject: Re: [uml-devel] patch warnings
References: <838f7c500505241233389fd6b9@mail.gmail.com>
In-Reply-To: <838f7c500505241233389fd6b9@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505250329.23931.blaisorblade@yahoo.it>
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
Date: Wed, 25 May 2005 03:29:21 +0200
To: user-mode-linux-devel@lists.sourceforge.net, ashwin tanugula <ashwin.tanugula@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net

On Tuesday 24 May 2005 21:33, ashwin tanugula wrote:
> Hi!
> When i tried to generate a patch, it gave me the following erros
>
> root@slemieux:/home/ashwin # diff -Naur
> /home/ashwin/uml/linux-2.6.0-test9/ linu x-2.6.0-test9/ >
> umlppc-patch1-2.6.0-test9
> diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm/arch: No such
> file or direc tory
> diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm-ppc/arch: Too
> many levels o f symbolic links
Hmm, let me divinate what you did before...you have tried to build UML (which 
creates include/asm/arch while asm was pointing to asm-ppc!! Right?
> diff: /home/ashwin/uml/linux-2.6.0-test9/include/asm-um/arch: No such
> file or di rectory

> can i ignore them?
Yes, you can, however they are for invalid symlinks... btw, you should really 
clean the tree after creating the patch and make sure you've not patched what 
should be a symlink...
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
