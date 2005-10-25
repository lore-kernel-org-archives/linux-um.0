Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EUXEN-0005ZJ-SA	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:25:19 -0700
Received: from rimuhosting.com ([69.90.33.248])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44)	id 1EUXEN-0003Ge-Ig
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 15:25:19 -0700
Message-ID: <435EB0C8.3050609@rimuhosting.com>
From: Peter <peter.spamcatcher@rimuhosting.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS race condition status?
References: <43542ACC.7020108@theshore.net> <435E60F1.2010005@linode.com>
	<435EAA6E.6070107@rimuhosting.com> <435EAD3B.8020900@linode.com>
In-Reply-To: <435EAD3B.8020900@linode.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
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
Date: Wed, 26 Oct 2005 11:25:12 +1300
To: "Christopher S. Aker" <caker@linode.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Blaisorblade <blaisorblade@yahoo.it>

HT is not disabled on any of my boxes.

Christopher S. Aker wrote:
> Peter wrote:
> 
>> I have skas3-v8 host servers with model 4 processes and good (100+ 
>> day) uptimes.  The host server I had issues with (host38) got 
>> converted to Xen and is still having problems.  I am seeing issues 
>> with host34 that require the odd restart.  That server runs the same 
>> CPU model and kernel code as other servers of mine with good uptime.
>>
>> My conclusion is that I must be seeing hardware issues rather than a 
>> skas bug.
> 
> 
> By chance, do you have Hyperthreading disabled on your model 4 Xeon boxes?
> 
> -Chris


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
