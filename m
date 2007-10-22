Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ik784-0007q7-PE for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 16:56:17 -0700
Received: from gw.goop.org ([64.81.55.164] helo=mail.goop.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ik783-0007X9-Gq
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 22 Oct 2007 16:56:16 -0700
Message-ID: <471D389E.40609@goop.org>
Date: Mon, 22 Oct 2007 16:56:14 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
MIME-Version: 1.0
References: <20071022061245.GG2998@hacking> <87d4v7fy5i.fsf@hades.wkstn.nix>
	<20071022065202.GI2998@hacking>
	<20071022065943.GC10864@uranus.ravnborg.org>
	<20071022074823.GJ2998@hacking>
	<20071022113600.GA8181@ftp.linux.org.uk>
	<20071022122504.GL2998@hacking>
	<20071022124322.GB8181@ftp.linux.org.uk>
	<20071022124551.GA7438@elte.hu> <471D2ECC.6090209@goop.org>
	<20071022231927.GA30814@elte.hu>
In-Reply-To: <20071022231927.GA30814@elte.hu>
Subject: Re: [uml-devel] User Mode Linux still doesn't build in 2.6.23-final.
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
To: Ingo Molnar <mingo@elte.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Paolo Giarrusso <p.giarrusso@gmail.com>, linux-kernel@vger.kernel.org, Nix <nix@esperi.org.uk>, Rob Landley <rob@landley.net>, Al Viro <viro@ftp.linux.org.uk>, WANG Cong <xiyou.wangcong@gmail.com>, Sam Ravnborg <sam@ravnborg.org>

Ingo Molnar wrote:
> * Jeremy Fitzhardinge <jeremy@goop.org> wrote:
>
>   
>> Ingo Molnar wrote:
>>     
>>> we should kill it there too.
>>>
>>> the only place where we should _please_ keep those annotations are for 
>>> functions that get called from assembly code. This makes life immensely 
>>> easier for -pg (CONFIG_FUNCTION_TRACING) kernels.
>>>       
>> Should we re-add them for the function pointers in asm-x86/paravirt.h?
>>     
>
> yes, yes, yes. :-) It was a nightmare to sort it out in -rt (and still 
> is). 

Do you have a patch to do this already?

>> Andi argued we should remove them since x86 is unconditionally regparm 
>> now anyway - and they're pretty ugly syntactically.
>>     
>
> Sure, it doesnt make things prettier, but i didnt see any particular 
> ugliness.

Hm, how can we get gcc to complain about inconsistent use of fastcall? 
It doesn't generate any warnings if the function and its pointer are
inconsistent, presumably because everything is regparm(3) anyway...

    J

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
