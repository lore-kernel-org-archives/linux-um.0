Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EURun-0006E3-Kg	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 09:44:45 -0700
Received: from ns.theshore.net ([67.18.92.50] helo=www.theshore.net)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EURui-0005OT-GY
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 25 Oct 2005 09:44:42 -0700
Message-ID: <435E60F1.2010005@linode.com>
From: "Christopher S. Aker" <caker@linode.com>
MIME-Version: 1.0
Subject: Re: [uml-devel] SKAS race condition status?
References: <43542ACC.7020108@theshore.net>
In-Reply-To: <43542ACC.7020108@theshore.net>
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
Date: Tue, 25 Oct 2005 11:44:33 -0500
To: user-mode-linux-devel@lists.sourceforge.net
Cc: peter.spamcatcher@rimuhosting.com, Blaisorblade <blaisorblade@yahoo.it>

Christopher S. Aker wrote:
> Has there been any progress on the race in SKAS?  I've been dealing with 
> 2-4 hosts crashing a week.  Same thing happens on my old SKAS kernel, 
> 2.6.7 with skas3-v4 or so.

Jeff and I realized that this only happens on Xeon processors where the 
model number is > 2.  None of my model 2 Xeon hosts crash, but my model 
3 and model 4 xeons do.  grep model /proc/cpuinfo for info.  I've had 
skas3-v4 and skas3-v8.2 generate the same panic, so it's something 
processor model specific.

Peter, can you verify the problems you've had are on hosts with a model 
3 or 4 Xeon processor?  Also, with regard to 2.6.12, I'm not sure we're 
looking at the same issue, as I had problems with that kernel too but 
wasn't able to verify it was the same panic.  I have had 2.6.13 working, 
and it does generate the same SKAS panic eventually.

Thanks,
-Chris


-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.
Get Certified Today * Register for a JBoss Training Course
Free Certification Exam for All Training Attendees Through End of 2005
Visit http://www.jboss.com/services/certification for more information
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
