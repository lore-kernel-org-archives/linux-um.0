Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1ATA0L-0006os-Hr
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 17:16:05 -0800
Received: from mail.gmx.net ([213.165.64.20])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1ATA0K-0000RP-TK
	for user-mode-linux-devel@lists.sourceforge.net; Sun, 07 Dec 2003 17:16:05 -0800
Message-ID: <05bc01c3bd29$7766a3f0$2000000a@schlepptopp>
From: "roland" <for_spam@gmx.de>
References: <Pine.LNX.4.44.0312070010550.16967-100000@filer.marasystems.com>
Subject: Re: [uml-devel] Re: bug in COW? - Re: [uml-user] uml 2.6.0-test9 crash
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
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
Date: Mon, 8 Dec 2003 02:20:27 +0100
To: Henrik Nordstrom <hno@marasystems.com>, Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, uml-user <user-mode-linux-user@lists.sourceforge.net>

hi !

> Note to others: The SF bug/patch tracker looks nice, but is in my opinion
> really awful to use for the purpose. I am not going to actively look in 
> these tools.
mhh - that really is a matter of taste. from my personal view, i find it 
difficult to track patches or bugs if one must dig for that into a ML 
archive. for you developers it`s ok, to filter them out from the ML. but - if 
other people want to take a look, what problems have probably been resolved, 
they don`t have the same "view" of the things, like you have, because your 
bugfix/patchcollection is somewhat "non public" (because of too much "ML-noise" 
around). isn`t it? from another sf-projekt i`m related somewhat (rockbox) i can 
say: bug and patchtracking seems to work just fine. the project maintaines even 
recommend, that contributors should sending language-file-updates as patches to SF 
patchtracker. everybody can easily take it out there - add comments - and more 
important - see what the status is or when it has been merged. as an example, the 
"configuration management" the rockbox/haxx.se guys (btw: curl is from them,too) is 
marvellous, imho. (see http://rockbox.haxx.se ->recent cvs activity,daily builds,cvs 
compile status,bleeding edge builds,bug reports,patches....  )
just cool! 
ok - we cannot really compare these projects side by side, they are very different.

>No, simply UML 2.6 works only if you don't enable module support. Obviously 
>this is a bug, and patches have been posted around 5-6 times or so(search in 
>the archives, but some modules could not work anyway because some symbols 
>must still be exported); but no fix has gone in Jeff's patch.
see what i mean? 5-6 times posted - but people need a helping hand to find them.
ok - i cannot arrogate, to tell you code wizards(respect!) how to work - but perhaps 
i can give some pro`s/con`s. okok - last words - i shut up now ;)

regards
roland



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
