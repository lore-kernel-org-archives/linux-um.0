Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgE1t-00005O-7G
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 21:33:17 +0000
Received: by sipsolutions.net with esmtpsa
 (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
 (Exim 4.94) (envelope-from <johannes@sipsolutions.net>)
 id 1kgE1r-00BcFA-GJ
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 22:33:15 +0100
Message-ID: <9731397936ba99253548843d9e487ce0df44bdce.camel@sipsolutions.net>
Subject: Re: [PATCH 4/4] um: allow PM with suspend-to-idle
From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 20 Nov 2020 22:33:01 +0100
In-Reply-To: <20201120222625.7a475c89cdd4.Id4fe7fb6f0405eb24f3db3ae7a6276293f0ce6f7@changeid>
References: <20201120212921.880781-1-johannes@sipsolutions.net>
 <20201120222625.7a475c89cdd4.Id4fe7fb6f0405eb24f3db3ae7a6276293f0ce6f7@changeid>
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

On Fri, 2020-11-20 at 22:29 +0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In order to be able to experiment with suspend in UML,
> add the minimal work to be able to suspend (s2idle) an
> instance of UML, and be able to wake it back up from
> that state with the USR1 signal sent to the main UML
> process.

So what I said about rtcwake ... maybe that's an argument for removing
the USR1 handling? I wasn't really too sure about it.

But on the other hand, typically real systems will have at least *some*
kind of wakeup source that you can manually use and that's always
enabled, perhaps the power button for example; the SIGUSR1 handling was
meant to simulate such a thing.

(Today, if you send SIGUSR1 to the main 'linux' process, it just dies,
but I hope nobody relies on that ...?)

johannes


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

