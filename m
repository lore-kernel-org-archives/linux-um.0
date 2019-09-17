Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.2 #3 (Red Hat Linux))
 id 1iADrG-0001va-Kk
 for linux-um@lists.infradead.org; Tue, 17 Sep 2019 13:49:31 +0000
Message-ID: <2a6fc1c8ab6312ad0683d3b4f6f11767b1803929.camel@sipsolutions.net>
Subject: Re: [RFC v3 2/2] um: implement time-travel=ext
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 17 Sep 2019 15:49:27 +0200
In-Reply-To: <ddaf73a2-762a-91d2-40ab-d432e363d52b@kot-begemot.co.uk>
References: <20190917132943.20102-1-johannes@sipsolutions.net>
 <1568726354-I0c06fae89d77d5b272dfb4c7ea64641b597b5c7b@changeid>
 <a8a2a033d8dc988c34d321425b7d0baa65b8df81.camel@sipsolutions.net>
 <ddaf73a2-762a-91d2-40ab-d432e363d52b@kot-begemot.co.uk>
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
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, linux-um@lists.infradead.org

On Tue, 2019-09-17 at 14:47 +0100, Anton Ivanov wrote:

> > Though, come to think of it, I probably broke modular builds again here.
> 
> :)

I'll fix it later, or maybe I'll just prohibit it, though there isn't
really a strict reason to other than not having to sprinkle
EXPORT_SYMBOL all over.

> > Anyway, I won't send a new version soon I think, comments welcome and
> > I'll see how the qemu changes progress.
> 
> As I said - I am going to wait for Richard's next PR so I have a settled 
> tree and I will get on with testing. I should have a bit more time then 
> as well as ONS Europe will be out of the way. At the moment all of my 
> time is being eaten by various k8 related stuff for that.

Sure, thanks. I'll keep rebasing this as that happens too, maybe I
should publish a git tree on kernel.org for it?

Not that I really expect you to (want to) test all the time-travel
stuff, it seems like a fairly niche feature :-)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

