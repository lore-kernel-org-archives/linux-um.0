Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GTn3l-0001fQ-Hm for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 15:11:49 -0700
Received: from gwu.lbox.cz ([62.245.111.132])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GTn3j-0005tY-Rk
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 30 Sep 2006 15:11:49 -0700
Received: from linuxbox.linuxbox.cz (linuxbox.linuxbox.cz [10.76.66.10])
	by gwu.lbox.cz (Sendmail) with ESMTP id k8UMBeQS008568
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 00:11:40 +0200
Received: from [10.76.66.65] (nbnik.linuxbox.cz [10.76.66.65])
	(authenticated bits=0)
	by linuxbox.linuxbox.cz (Sendmail) with ESMTP id k8UMBcEh010979
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 1 Oct 2006 00:11:38 +0200
Message-ID: <451EEB99.6030406@linuxbox.cz>
Date: Sun, 01 Oct 2006 01:11:37 +0300
From: Nikola Ciprich <nikola.ciprich@linuxbox.cz>
MIME-Version: 1.0
References: <451E9BAB.5030009@linuxbox.cz>
	<20060930214902.GA16457@ccure.user-mode-linux.org>
In-Reply-To: <20060930214902.GA16457@ccure.user-mode-linux.org>
Subject: Re: [uml-devel] SKAS mode not working, x86_64 SMP host, x86_64 guest, 
	problems with noprocmm
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
To: user-mode-linux-devel@lists.sourceforge.net

Hi Jeff,
thanks for reply!
yup, skas0 seems to be working quite OK, but do You have an idea where 
could be problem with shutting down? (this Virtual timer expired cycling?)
and regarding /proc/mm, shouldn't this mm64 file be used? or what's it 
used for?
nik

Jeff Dike wrote:
> On Sat, Sep 30, 2006 at 07:30:35PM +0300, Nikola Ciprich wrote:
>   
>> I've been trying to get x86_64 guest UMLs working on SMP x86_64 host 
>> machine for quite long time, during today and yesterday I've also 
>> checked 2.6.18 (+ both skas & skas-fremap v9pre9), but it's still not 
>> working as good as 32bit/32bit was working for me for last few years ;). 
>>     
>
> skas0 works fine (as well as on i386) afaik.
>
> Putting a stock kernel on the host or "noprocmm" on the UML command line
> will put you in skas0 mode.
>
>   
>> I've noticed on some other discussions that SKAS mode is still not fully 
>> working on x86_64, so I'd like to ask, what are remaining issues, and 
>> maybe could I somehow try helping in fixing them? 
>>     
>
> Well, the -EINVAL return from writing /proc/mm would be a good place
> to start looking to fix things :-)
>
> 				Jeff
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys -- and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>
>   


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
