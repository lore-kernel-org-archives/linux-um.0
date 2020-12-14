Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kox05-0002kT-L9
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 23:11:30 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kowzz-0096Az-1o
 for linux-um@lists.infradead.org; Tue, 15 Dec 2020 00:11:24 +0100
Message-ID: <48d0bed5644b98c8bc2e3001e778843a122109bf.camel@sipsolutions.net>
Subject: Re: [PATCH 3/4] um: time-travel: rework interrupt handling in ext mode
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 15 Dec 2020 00:11:04 +0100
In-Reply-To: <20201214130826.256439c864b0.I1a38036a693dccc9da905e47f1b4dc933ac305cf@changeid>
References: <20201214130826.5c1b7720a11b.Ibacb1cbbdd1fa7ae866f0c3c94488dcbae01b39b@changeid>
 <20201214130826.256439c864b0.I1a38036a693dccc9da905e47f1b4dc933ac305cf@changeid>
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
To: linux-um@lists.infradead.org

On Mon, 2020-12-14 at 13:08 +0100, Johannes Berg wrote:
> 
> Add a um_request_irq_tt() function that let's a time-travel aware
> driver request an interrupt with an additional timetravel_handler()
> that is called outside of the context of the simulation, to handle
> the message only. It then adds an event to the time-travel calendar
> if necessary, and no "real" Linux code runs outside of the time
> simulation.
> 
> This also hooks in with suspend/resume properly now,

Perhaps not. I think we need a separate signal handler in that case, so
that we don't have all the lockdep et al machinery active.

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

