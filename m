Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQuqV-0001Cm-8u
 for linux-um@lists.infradead.org; Fri, 09 Oct 2020 16:02:15 +0000
Message-ID: <fe1413de641b25537ee2d4b7463c8fa5eb4b9993.camel@sipsolutions.net>
Subject: Re: [RFC v7 07/21] um: extend arch_switch_to for alternate SUBARCH
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 09 Oct 2020 18:02:12 +0200
In-Reply-To: <m2sgao42fa.wl-thehajime@gmail.com>
 (sfid-20201009_032432_010821_E55BA25D)
References: <cover.1601960644.git.thehajime@gmail.com>
 <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
 <5502f24bcdc07372fbc5ee86c700770038b041c4.camel@sipsolutions.net>
 <m2sgao42fa.wl-thehajime@gmail.com> (sfid-20201009_032432_010821_E55BA25D)
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-arch@vger.kernel.org, tavi.purdila@gmail.com, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, retrage01@gmail.com, linux-kernel-library@freelists.org, anton.ivanov@cambridgegreys.com

On Fri, 2020-10-09 at 10:24 +0900, Hajime Tazaki wrote:
> On Thu, 08 Oct 2020 00:25:06 +0900,
> Johannes Berg wrote:
> > On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> > > This commit introduces additional argument of previous task when
> > > context switch happens.  New SUBARCH can use the new information to
> > > switch tasks in a subarch-specific manner.
> > > 
> > > The patch is particularly required by nommu mode implemented as a
> > > SUBARCH of UML.
> > 
> > Would probably be good to already say why here?
> 
> Agree.
> 
> The patch is particularly required by nommu mode because it uses
> previous task information to control the previous thread (e.g., down
> semaphore, terminate thread, clean up thread flags).
> 
> Something like this ?

Well, still not sure I like "nommu" to refer to "library mode", but I'm
also not sure that you can understand that without the context of how
threads actually work in library mode?

Maybe even something vague like

   Having access to the previous thread will be required in library mode
   for it to implement thread switching correctly.

would give some rationale?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

