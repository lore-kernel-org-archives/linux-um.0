Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HOMmx-0007PB-NB for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:40:19 -0800
Received: from server.ispbrasil.com.br ([209.67.213.238] helo=ispbrasil.com.br)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HOMmv-0000bg-Oz
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Mar 2007 15:40:19 -0800
Message-ID: <007a01c75f7f$9ee595c0$fe0fa8c0@ispbrasil>
From: "Itamar Reis Peixoto" <itamar@ispbrasil.com.br>
References: <e3156df0612142300if4a4d8akabae7f81d0d6695e@mail.gmail.com>
	<200703052339.39509.blaisorblade@yahoo.it>
Date: Mon, 5 Mar 2007 21:40:10 -0200
MIME-Version: 1.0
Subject: Re: [uml-devel] [PATCH] broken uml_util.spec
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Blaisorblade <blaisorblade@yahoo.it>, user-mode-linux-devel@lists.sourceforge.net
Cc: Ilkka Tengvall <ilkka.tengvall@iki.fi>

about uml_util.spec, this patch have yo fixed the problem of unpackaged file 
(jail_uml)?

%attr(755,root,root)                    %{_sbindir}/jail_uml


--------------------

Itamar Reis Peixoto

e-mail: itamar@ispbrasil.com.br
msn: itamarjp@starmedia.com
skype: itamarjp
icq: 81053601
+55 34 3238 3845
+55 11 4063 5033
----- Original Message ----- 
From: "Blaisorblade" <blaisorblade@yahoo.it>
To: <user-mode-linux-devel@lists.sourceforge.net>
Cc: "Ilkka Tengvall" <ilkka.tengvall@iki.fi>
Sent: Monday, March 05, 2007 8:39 PM
Subject: Re: [uml-devel] [PATCH] broken uml_util.spec


> On Friday 15 December 2006 08:00, Ilkka Tengvall wrote:
>> Howdy,
>>
>> I just dowloaded uml and gave it a shot. Seems to work nice on
>> 2.6.19-rc6. While at it, I fixed the rpm spec file. It had old tag for
>> license, incorrect directory name for build and was missing jail_uml
>> from files list. I built it on fedora-release-6-89 .
>
>> There is also a minor bug in the skas patch, it still uses
>> include/config.h in some proc-mm files even config.h is removed from
>> 19-rc6 version of kernel. Just remove those includes, and it works for
>> me...
> (Fixed time ago).
>> I'm not a subscriber to the list.
> Thanks, I've applied this some time ago to my tree, on uml_util.spec.in.
>
> Bye
> -- 
> Inform me of my mistakes, so I can add them to my list!
> Paolo Giarrusso, aka Blaisorblade
> http://www.user-mode-linux.org/~blaisorblade
> Chiacchiera con i tuoi amici in tempo reale!
> http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com
>
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share 
> your
> opinions on IT & business topics through brief surveys-and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
> 


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
