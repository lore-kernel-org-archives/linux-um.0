Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kQBJU-0003IW-T4
 for linux-um@lists.infradead.org; Wed, 07 Oct 2020 15:25:09 +0000
Message-ID: <5502f24bcdc07372fbc5ee86c700770038b041c4.camel@sipsolutions.net>
Subject: Re: [RFC v7 07/21] um: extend arch_switch_to for alternate SUBARCH
From: Johannes Berg <johannes@sipsolutions.net>
Date: Wed, 07 Oct 2020 17:25:06 +0200
In-Reply-To: <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
References: <cover.1601960644.git.thehajime@gmail.com>
 <d4a65be8d05d945885f53bc168fd85f08e72adf1.1601960644.git.thehajime@gmail.com>
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
To: Hajime Tazaki <thehajime@gmail.com>, linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: tavi.purdila@gmail.com, linux-kernel-library@freelists.org, retrage01@gmail.com, linux-arch@vger.kernel.org

On Tue, 2020-10-06 at 18:44 +0900, Hajime Tazaki wrote:
> This commit introduces additional argument of previous task when
> context switch happens.  New SUBARCH can use the new information to
> switch tasks in a subarch-specific manner.
> 
> The patch is particularly required by nommu mode implemented as a
> SUBARCH of UML.

Would probably be good to already say why here?

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

