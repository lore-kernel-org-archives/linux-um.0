Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Joel Palmius <joel.palmius@miun.se>
In-Reply-To: <200512202123.34630.blaisorblade@yahoo.it>
Message-ID: <Pine.LNX.4.64.0512202151210.11265@ligur.jwp.se>
References: <Pine.LNX.4.63.0510161818210.10902@ligur.student.mh.se>
	<20051215201530.GA10705@ccure.user-mode-linux.org>
	<200512161703.14319.blaisorblade@yahoo.it>
	<200512202123.34630.blaisorblade@yahoo.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Subject: [uml-devel] Re: Bug in COW format - 64-bit incompatible with 32-bit
	due to struct padding (was: Re: [uml-user] uml_moo and large files)
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
Date: Tue, 20 Dec 2005 22:13:54 +0100 (CET)
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net

On Tue, 20 Dec 2005, Blaisorblade wrote:

> So we need an utility doing just the setup and the writeout. Should be easy to
> do, but I must learn the complete COW API. I will dismiss this task if I see
> (as it seems) that there are no existing COW files.

Personally I stopped trusting COW files once I saw I couldn't moo them, so 
I simply haven't used COWs. I guess most people trying COWs on an amd64 
system with 32bit umls would reach the same conclusion pretty fast.

   // Joel


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
